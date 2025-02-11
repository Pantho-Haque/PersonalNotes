# tRPC (Typescript Remote Procedure Call)

- Framework
- builds type-safe api

## Comparison

### REST API

- create endpoints (/users, /posts, /orders).
- frontend makes HTTP requests (GET, POST, PUT, DELETE).
- backend processes the data to send response
- manual defination of routes and manual error handling
- postman/swagger for documentation

### GraphQL API

- there is only a single endpoint (/graphql).
- frontend requests specific data
- Needs a schema and a special GraphQL query language.
- complex schema setup

### tRPC

- No endpoints or queries, simple function call -> procedure
- automatic inference - any code changes in frontend will also be known by frontend
- Request batching - combines multiple tRPC calls into a single HTTP request to minimize the network traffic

```ts
const user = trpc.user.getUser.useQuery({ id: "123" });
const posts = trpc.post.getPostsByUser.useQuery({ userId: "123" });
```

`can be write with`

```ts
const utils = trpc.useContext();
utils.batch(() => {
  trpc.user.getUser.prefetch({ id: "123" });
  trpc.post.getPostsByUser.prefetch({ userId: "123" });
});
```

- `prefetch` method fetch the result and store it on cache. whenever we call `useQuery` it will look for that cache, when not sending a HTTP network request again.
- to enable batching we have to make a configuration file with this configuration settings

```ts
//src/pages/api/trpc/[trpc].ts - in NextJs
import { createNextApiHandler } from "@trpc/server/adapters/next";
import { appRouter } from "../../../server/router";

export default createNextApiHandler({
  router: appRouter,
  createContext: () => ({}),
  batching: {
    enabled: true, // This line enables request batching.
  },
});
```

## Setting Up a Next.js App with tRPC

```bash
npx create-next-app@latest my-trpc-app --typescript
cd my-trpc-app
npm install @trpc/server @trpc/client @trpc/react-query superjson zod
```

- the folder structure

```bash
my-trpc-app/
├── pages/
│   ├── api/
│   │   └── trpc/
│   │       └── [trpc].ts       # tRPC API handler for Next.js
│   └── _app.tsx                # Custom App component (where you'll integrate tRPC client)
├── server/
│   ├── routers/
│   │   ├── _app.ts             # Main router that combines all individual routers
│   │   └── user.ts             # Example router for user-related procedures
│   └── trpc.ts                 # tRPC initialization (context creation and tRPC router setup)
├── package.json
└── tsconfig.json

```

## Setting up a tRPC Router & Context

```ts
// server/trpc.ts
import { initTRPC } from "@trpc/server";

// creating context for users -> returns an object available for all users.
export const createContext = () => {
  return {
    user: null, // simulates a nonauthenticated state
  };
};
export type Context = ReturnType<typeof createContext>;
// seuping trpc with our context
const t = initTRPC.context<Context>().create();

// middleware that checks user is authenticated or not
const isAuthenticated = t.middleware(({ ctx, next }) => {
  if (!ctx.user) {
    throw new Error("Not authenticated");
  }
  return next({
    ctx: {
      user: ctx.user,
    },
  });
});

// router and procedures
export const router = t.router;
export const publicProcedure = t.procedure;
export const protectedProcedure = t.procedure.use(isAuthenticated);
```

## Defining Procedures in a Router

```ts
// server/routers/user.ts
import { publicProcedure, protectedProcedure, router } from "../trpc";
import { z } from "zod";

export const userRouter = router({
  //public procedure
  getUser: publicProcedure
    .input(z.object({ id: z.string() }))
    .query(({ input }) => {
      return {
        id: input.id,
        name: "John Doe",
        email: "john@example.com",
      };
    }),

  // protected procedure (if you want to restrict access)
  getSecret: protectedProcedure.query(({ ctx }) => {
    return {
      secret: `Your secret is 42, and your user is ${ctx.user}`,
    };
  }),
});
```

##  Combining Routers

```ts
// server/routers/_app.ts
import { router } from '../trpc';
import { userRouter } from './user';

export const appRouter = router({
  user: userRouter,
});

// Export type definitions for the API ->  allows the frontend to infer types automatically 
export type AppRouter = typeof appRouter;
```

<!-- ## Route and Procures

- example.com/innovation.hello
  - innovation -> route (like a folder)
  - hello -> procedure (like a file) -->
