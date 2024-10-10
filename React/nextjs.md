# Next js

- react - conserns with user interface only
- we need

  - data fetching
  - routing
  - caching
  - font and img optimization
  - client / server side rendering
  - seo

- Client side rendering
  - search engine bot ignores the whole application
    - > there exist only a root div available on the page
    - > as its client side rendering , all the js comes to client and then it beguns rendering
    - > bot comes and see no content with only root div. cause it takes time to load completely the js from the server. bot leaves
    - > no seo
  - poor performance
  - delay for first contententful paint
  - large Time to interactive(state where user can interact with the application)
- Serverside rendering

  - simulates a browser on server and check whats the ultimate generated html and css and then send those html and css to client.
  - this happens for the first time.After arriving the whole js, it continues client side rendering for its lifetime
  - assuring first contentful paint
  - good seo
  - poor performance
  - simple trick to cheat with google bot
  - large tti

- React Server Component
  - component with no interactivity will render in server then stream to client
  - component with interactivity will render in client side.
  - dont need to wait for the whole bundle to render in client
  - fast tti

## Setup

```cmd
npx create-next@latest
.   // project name . if want to initialize on current folder
no  // typescript
yes // eslint
yes // tailwindcss
no  // full project in src/ directory
yes // app router
no // import alias
```

-- give us a boyler-plate

```cmd
npx run dev
```

## Routing

- use `Link` component to control routing > client side navigation
  - using `a` tag causes reload the page
- for folder `app/about/page.js`

  - route will be `localhost:3000/about`
  - `<Link href-"/about">Home</Link>`

- for folder `app/about/mission/page.js` (**nested route**)
  - route will be `localhost:3000/about/mission`
  - `<Link href-"/about/mission">Mission</Link>`

## Dynamic routing

```js
const blogs = [];
return (
  <main>
    <ul>
      {blogs.map((blog) => {
        <li>
          <Link key={blog.id} href={`/blogs/${blog.id}`}>
            {blog.title}
          </Link>
        </li>;
      })}
    </ul>
  </main>
);
```

- now create `blogs/[id]/page.js`
- params object has the value of all parameters

```js
export default function BlogPage({params}){
  const {id}=params; // id is a string

  return();
}

```

- but this makes the site dynamic, cause server dont know how may id there can be, so it cant generate raw html,css from thet route
- but we can make this static by telling the assumed value of `id`
- on the same `page.js` after the `PostPage` component

```js
export async function generateStaticParams(){
    const posts = await getAllPost()
    return posts.map(post=>({
      id:post.id.toString(),
    }))
}
```

- this is called static site generation (ssg)
  - it generated in build time but can receive dynamic props

## Layout

- app/layout.js (RootLayout)
  - this layout file will run for every page
  - it has a children component which is the content of page.js inside of that route
- app/about/layout.js
  - this applies for only the pages inside the "about" route segment

## Fallback Loading

- in a folder `app/about/loading.js`
- this component will work as the loader for all pages inside that segment
- for full app loader - `app/loading.js`
- uses react suspense

## Error handeling (client side)

- `app/about/error.js`
  - used for handling all errors inside this route
- `"use client"` indicates a client component

## 404 not-found page

- create `app/not-found.js`
- this component works as 404 page.
- programmatically call
  - `import {notFound} from "next/navigation";`
  - `if(){ notFound() }`
  - will search the nearest not found page

## Image optimization

- `import imgname from "@/public/assets/thumb.js"`
- `<Image src={imgname} alt="Thumb image" quality={} placeholder="blur" />`

## Font optimization

- `import {Poppins} from "next/font/google"`
- `const poppins=Poppins({subsets:["latin"],weight:"400"})`
- `<div className={poppins.className}></div>`

## Metadata

- static metadata written in Layout
  - they are being used for every page of that layout has

```js
export const metadata = {
  title: "about us",
  description: "next app",
};
```

- dynamic metadata used in dynamic route

```js
export async funtion generateMetadata({params}){
  // this function gets the params as same as the main function getting

  const {id} = params;
  const post = await getPost(id);
  
  return {
    title:post.title,
    description:post.body
  }
}
```

## Data fetching

- create `lib/getAllPosts.js`

```js
export default async function getAllPosts() {
  const result = await fetch(
    "https://jsonplaceholder.typicode.com/posts?_limit=10",
    {
      // additional option from next js 
      cache:"force-cache"(default)|"no-store", // but this one make the component dynamic
      // static comp-> build to html,css on server when maked production
      // dynamic comp-> build to html,css on server after client request 
      next: {
          revalidate:10, // in seconds
      }

    }
  );

  if(!result.ok){
    throw new Error("Error occured while fetching");
  }
  
  return result.json();
}
```

- create `app/posts/page.js`

```js
  import getAllPosts from "@/lib/getAllPosts";
  export default async function Posts(){
    const posts= await getAllPosts();

    return(
      <ul>
        {posts.map(post=> <li key={post.id}>{post.title}</li>)}
      </ul>
    )
  }
```

## Progressive Rendering

```js
export default async function Post({params}){
  const {id} = params

  const postPromise = getPost(id);
  const commentsPromise=getComment(id);

  // const [post,comments]= await Promise.all([postPromise,commentsPromise])
  // calls 2 promisses at a time and waits for the final render 
  // not good practice 

  const post = await postPeomise;

  return(
    // code for post 

    <Suspense fallback="<h1>comments are loading</h1>">
        <Comments promise={commentPromise} /> 
    </Suspense>
    // thus when the post is loaded user can see this 
    // even if comments take time to come from server it has suspence to take time till fully arrives
  )
}
```
