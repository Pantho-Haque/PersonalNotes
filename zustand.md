## install

```
    npm install zustand
```

## initialize

#### store.js

```js
    import create from "zustand";

    const useStore = create(
        (set) => ({
            book: null,
            addBook: (data) =>
                set((state) => ({
                book: data,
                })),
            removeBook: (data) =>
                set((state) => ({
                book: null,
                })),
        })
    );

    export default useStore;
```

## use the data

```js
    import useStore from "./store";

    const book = useStore(          (state) => state.book       );
    const addBook = useStore(       (state) => state.addBook    );
    const removeBook = useStore(    (state) => state.removeBook );

    const submit = () => {
        addBook(value);
    };
    const clear = () => {
        removeBook();
    };
```
