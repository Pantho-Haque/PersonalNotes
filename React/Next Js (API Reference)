# Next Js (API Reference)

## Directives

### use client
- entry point to render in client side
- write **'use client';** on top of file.
- props of client component must be **serializable**. Cause react sends those props from server component to client component through the network. So any **non-serializable** props will cause an error.
    - **Serializable :** string,number, object,null etc.
    - **Non-serializable :** Functions, Class, ReactNode, Map/Set, BitInt
        > So we cant pass function as props, define the function inside the client component.
        
        > For complex objects, convert to plain JSON format before passing as props  
- use for interactive elements that needs state, effects, browser API's.

### use server
- entry point to render in server side
- write **'use server';** on top of file.
- also write **'use server';** inline to make a server function 
    ```ts
        async function updatePost(formData: FormData) {
            'use server'
            await savePost(params.id, formData)
            revalidatePath(`/posts/${params.id}`)
        }
    ```

## Components

### Font 

- NextJs has built-in automatic self-hosting for any font file.
- also conveniently use all Google Fonts which are *downloaded at build time* and self-hosted with the rest of your static assets. No requests are sent to Google by the browser.
    ```tsx
        import { Inter } from 'next/font/google'
        
        const inter = Inter({
            subsets: ['latin']
        })
        ...
        <html lang="en" className={inter.className}>
        ...
    ```
- Reference
    - src 
        - used in localeFonts
        ```ts
            import localFont from 'next/font/local'
            const myFont = localFont({
                // if its located in font directory inside app directry. 
                src: './fonts/my-font.woff2', 
                // for multiple source of fonts
                src:[
                    {path: './inter/Inter-Thin.ttf', weight: '100',},
                    {path: './inter/Inter-Regular.ttf',weight: '400',},
                    {path: './inter/Inter-Bold-Italic.ttf', weight: '700',style: 'italic',},
                ],
                weight: ['100','400','900'] // 3 possible values
                style:['italic','normal',oblique],
                subsets: ['latin']
            })
        ```




















