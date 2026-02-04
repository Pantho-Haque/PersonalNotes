# 📡 Long Polling: Real-Time Updates Without WebSockets
In modern web applications, users expect real-time updates — whether it's live notifications, file uploads, or chat messages. While WebSockets are often ideal for such cases, a simpler alternative called long polling works great for many use cases, especially when WebSocket support is limited. It provides near-real-time updates using standard HTTP requests.

## 🧠 What is Long Polling?

Long polling is a technique where the client makes an HTTP request to the server, but instead of immediately responding, the server holds the request open until it has new data to send or a timeout occurs. This helps simulate real-time updates without constantly hitting the server (as regular polling would do every few seconds).

## 🍝 Simple Analogy: A Restaurant Waitlist

To understand long polling, imagine you're at a busy restaurant:

- **Customer arrives and says:** *"Call me when my table is ready."*
- **Restaurant** adds their phone number to a list.
- **Table becomes free**, so the restaurant calls all waiting customers: *"Your table is ready!"*
- **Customer gets seated**, and the restaurant removes their number from the list.

In our app:

- **Customer = client browser**
- **Phone number = callback function**
- **Table = file uploaded**
- **Call = server notifying the client**

This is exactly what our long polling system does.

## 🧱 Backend Code (Express.js)

### 1.Shared Variables

We need two variables to store the last modification of the content and the list of waiting clients.
```ts
    let lastFileChange = Date.now();
    let clients: { resolveFunc: () => void }[] = [];
```

### 2. Notify All Waiting Clients

A function will be  triggered whenever the content changes its state. It updates the timestamp of lastFileChanges, clears the waiting list of client after taking a snapshot. Then call each clients resolve function.

```ts

    function notifyClients() {
        lastFileChange = Date.now();
        const currentClients = [...clients];
        clients = [];
        currentClients.forEach((client) => client.resolveFunc());
    }

```

### 3. Wait for Changes to Timeout

Another function will give the client a decision that the content has been changed or not.This is the function that holds the clients request and save the response(resolve function of response) to our globar client array. Along with that it also sets a timer if there is no change on the file for a particular time, it returns response with no change.

```ts 

    async function waitForChanges(since: number) {
        if (since < lastFileChange) {
            return true;
        }
        return new Promise((resolve) => {

            const timeout = setTimeout(() => {
                console.log("30 seconds passed, no changes detected");
                clients = clients.filter((c) => c.resolve !== resolve);
                resolve(false);
            }, 30000);


            clients.push({
                resolveFunc: () => {
                    console.log("Change detected! Notifying client immediately");
                    clearTimeout(timeout);
                    resolve(true);
                },
            });
        });
    }

```

- `resolveFunc` is a callback function that is being preserved to the global variable `clients` so that whenever we need to notify that client we can resolve that by calling that function.

## API Endpoints

### GET request(The Long Poll Handler)

We must hit a endpoint to get content from server. Here its getting the correct content is the request url has no `poll` parameter. Otherwish it will hold the request by calling the function `waitForChanges`. 
```ts

    app.get('/api/files', async (req, res) => {
        const { fileName, since, poll } = req.query; 
        
        // polling
        if (poll === 'true' && !fileName) {
            const sinceTimestamp = parseInt(since || '0', 10); 
            const hasChanges = await waitForChanges(sinceTimestamp); 
            
            return res.json({ 
                changes: hasChanges, 
                timestamp: lastFileChange 
            });
        }
        
        const mockFiles = [
            { id: 1, name: 'file1.txt', size: 1024 },
            { id: 2, name: 'file2.txt', size: 2048 }
        ];
        
        res.json({ files: mockFiles }); 
    });

```
- `waitForChanges` returns a promise but no value, till the resolve anything with that value. 
- when the `notifyClients` function runs, those clients corresponding promises are being resolved. only then this response will be sent to the client. 
- Another case would occure if no file has been changes for 30 seconds.

### POST request (Trigger Notifications)

```ts
    
    app.post("/api/files", async (req, res) => {
        const { fileName, fileData } = req.body;
        console.log(`Processing file: ${fileName}`);

        notifyClients(); 

        res.json({ success: true, message: "File uploaded successfully" });
    });

```
- This will trigger the promise resolve function of all clients who have been sent request for poll. 

## 🖼️ Frontend Code (React)

### 1. The Polling Loop

- A reccursive function to impllement client side polling loop will send polling request with thee `poll=true` parameter, and checks for if any changes detected. 
- When backend runs `notifyClients` function, out client gets the response in `pollResponse` variable.
- We check here for changes and immediately fetch the fresh data.

```ts

    const pollForChanges = async (timestamp: number) => {
        try {
            const pollResponse = await fetch(`${BACKEND_URL}/api/files?poll=true&since=${timestamp}`);
            if (!pollResponse.ok) return; 

            const pollData = await pollResponse.json(); 

            if (pollData.changes) {
                console.log("Changes detected, refreshing file list..."); 

                const refreshResponse = await fetch(BACKEND_URL + "/api/files");
                if (refreshResponse.ok) {
                    const refreshData = await refreshResponse.json();
                    setFiles(refreshData.files); 
                }
            }

            setTimeout(() => pollForChanges(pollData.timestamp), 2000); 
        } catch (err) {
            console.error("Polling error:", err); 
            setTimeout(() => pollForChanges(Date.now()), 5000); 
        }
    };

```
- There has 2 second delay between polls to avoid overwhelming the server.
- Always use the server's timestamp for the next request

### 2. Start Polling After Fetching Files

```ts

    const fetchFiles = async () => {
        setIsLoading(true); 

        try {
            const response = await fetch(BACKEND_URL + "/api/files");
            if (!response.ok) {
                throw new Error("Failed to fetch files"); 
            }
            const data = await response.json(); 
            setFiles(data.files); 

            pollForChanges(Date.now());
        } catch (error) {
            console.error("Error fetching files:", error); 
        } finally {
            setIsLoading(false); 
        }
    };

```

## 🧪 Potential Improvements

For production use, consider these enhancements:
- **Authentication:** Add user authentication to long poll requests
- **Rate Limiting:** Prevent abuse with request rate limits
- **Redis Integration:** Use Redis pub/sub for multi-server coordination
- **Selective Updates:** Only notify relevant clients based on their interests
- **Connection Management:** Implement heartbeat to detect disconnected clients

## 🧯 When Not to Use It

- If you need **high-frequency updates** (e.g. chat, gaming).
- If **scaling** is critical — long polling can consume more server resources.
- In that case, consider **WebSockets** or **Server-Sent Events (SSE)**.
