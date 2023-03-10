# tailwind css

```sh
npm init -y
npm i -D tailwindcss
npx tailwindcss init

// src/input.css
    @tailwind base;
    @tailwind components;
    @tailwind utilities;
// package.json -> scripts{

    "build": "npx tailwindcss -i ./src/input.css -o ./src/output.css --watch",
}
// tailwind.cnfig.js
    module.exports = {
        content: ["./public/**/*.{html,js}"],
        theme: {
            extend: {},
        },
        plugins: [],
    }
// index.html
    <link rel="stylesheet" href="../src/output.css">

    
```

## Layout

### Aspect-{ratio}

```css

    aspect-auto aspect-square aspect-video

```

### Container

```css

    container
    /* for fixing an element's width to the current breakpoint.
        max width for
        sm : 640px
        md : 768px
        lg : 1024px
        xl : 1280px
        2xl: 1536px
    */

```

### Column,gap

```css

    columns-{count}
    /* for controlling the number of columns within an element.*/
    gap-{count}
    /* for controlling the gap betwn the columns */
    break-after-{column,page}
    /* for controlling how a column or page should break after an element.*/

```

### Box Decoration Break

```css

    box-decoration-{slice,clone}
    /* for controlling the number of columns within an element.*/

```

### Box Sizing

```css

    box-border
    /*  given size = border + padding
        content size= gizen size - border - padding
    */

    box-content
    /*  given size = content size
        total size = gizen size + border + padding
    */

```

### Display

```css
    inline  /* wrap the element normally */
    block
    inline-block
    flex
    inline-flex
    grid
    inline-grid
    hidden
    visible
    invisible

    table
    > table-header-group
      > table-row
      > table-cell

    > table-row-group
      > table-row
      > table-cell



```

### Float

```css
    float-{left,right,none}

    clear-{left,right,both,none}
    /*controlling the wrapping of content around an element*/

```

### Object fit

```css
    object-{contain,cover,fill,none,scale-down}

    object-{ right ,left ,top ,bottom,center,
             right-{top,bottom}, left-{top,bottom}
        }
    /*to set the specified position*/

```

### Overflow

```css
    overflow-{auto,x-auto,y-auto
              scroll,x-scroll,y-scroll
              visible,hidden,clip}

    object-{ right ,left ,top ,bottom,center,
             right-{top,bottom}, left-{top,bottom}
        }
    /*to set the specified position*/

```

### Position

```css
    static /* normal flow of the document. */
    fixed  /* relative to the browser window. offset is ignored */
    sticky
    relative /* normal flow of the document */
    absolute /* controls in an area of relatively positioned parent */

    top-{count}
    -top-{count}    /* using negative values */

    bottom-{count}
    -bottom-{count} /* using negative values */

    right-{count}
    -right-{count}  /* using negative values */

    left-{count}
    -left-{count}   /* using negative values */

    inset-{0 , x-0 , y-0 }

```

### Z-index

```css
    z-{0 , 10 , 20, 30 , 40 , 50 , auto }
    -z-{0 , 10 , 20, 30 , 40 , 50 , auto } /* using negative values */

```

## Flexbox & Grid

```css

/* parents classes */

    flex-{ row  , row-reverse  , col , col-reverse }
    flex-{ wrap , wrap-reverse , nowrap }

    grid-cols-{1-12,none}
    grid-rows-{1-6,none}
    grid-flow-{row , row-dense , col , col-dense }

    auto-cols-{auto , min , max , fr }
    auto-rows-{auto , min , max , fr }]

    gap-{ count , x-{count} , y-{count} }

    justify-{start , end , center , between , around , evenly } /* for flex */
    items-{start , end , center , baseline , stretch } /* align items */ /* for flex */

    justify-items-{start , end , center , stretch } /* for  grid */
    content-{start , end , center , between , around , evenly } /* for  grid.  */


    place-content-{start , end , center , between , around , evenly , stretch }
            /* content is justified and aligned at the same time. */ /* for grid */
    place-items-{start , end , center , stretch }

/* child classes */
    basis-{size}    /*  initial size of flex items */

    flex-1          /* flex: 1 1 0%; (grow 1, shrink 1 , basis 0%) */
    flex-auto       /* flex: 1 1 auto ; */
    flex-initial    /* flex: 1 1 initial ; */
    flex-none       /* flex: 1 1 none ; */

    grow            /* flex-grow: 1 */
    grow-0          /* flex-grow: 0 */

    shrink            /* flex-shrink: 1 */
    shrink-0          /* flex-shrink: 0 */

    order-{1-12 , first , last , none} /* order of flex and grid items. */

    /*  how elements are sized and placed across grid columns. */
    col-{
            auto ,
            span-{1-12, full } ,
            start-{1-13 , auto } ,
            end-{1-13 , auto } ,
        }

    row-{
            auto ,
            span-{1-6, full } ,
            start-{1-7 , auto } ,
            end-{1-7 , auto } ,
        }

    justify-self-{auto , start , end , center , stretch }
    self-{start , end , center , baseline , stretch } /* align self */
    place-self-{start , end , center , baseline , stretch }

```

## Spacing

```css
    p-{count}
        pt-{count} pb-{count} pr-{count} pl-{count}
        px-{count} py-{count}
    m-{count}
        mt-{count} mb-{count} mr-{count} ml-{count}
        mx-{count} my-{count}

    space-{ x-{count} , y-{count} , x-reverse , y-reverse }
    -space-{ x-{count} , y-{count} , x-reverse , y-reverse } /* negative value */

    count - [ px , auto ,
             0 , 0.5 , 1 , 1.5 , 2 , 2.5 , 3 , 3.5 ,
             4 , 5 , 6 , 7 , 8 , 9 , 10 , 11 ,
             12 , 14 ,
             16 , 20 , 24 , 28 , 32 , 36 , 40 , 44 , 48 , 52 , 56 , 60 ,
             64 , 72 , 80 , 96
            ]

```

## Sizing

```css
    w-{count , fraction , full , screen , min , max , fit }
    min-w-{count , fraction , full , screen , min , max , fit }
    max-w-{
            count , fraction , full , screen , min , max , fit
            none , xs , md , lg , xl , 2xl , 4xl , 5xl , 6xl , 7xl ,
            prose , screen-{ sm , md , lg , xl , 2xl }
        }
    h-{count , fraction , full , screen , min , max , fit }
    min-h-{count , fraction , full , screen , min , max , fit }
    max-h-{
            count , fraction , full , screen , min , max , fit
            none , xs , md , lg , xl , 2xl , 4xl , 5xl , 6xl , 7xl ,
            prose , screen-{ sm , md , lg , xl , 2xl }
        }

    fraction - [
            1/2 ,
            1/3 , 2/3 ,
            1/4 , 2/4 , 3/4 ,
            1/5 , 2/5 , 3/5 , 4/5 ,
            1/6 , 2/6 , 3/6 , 4/6 , 5/6 ,
            1/12 , 2/12 , 3/12 , 4/12 , 5/12 , 6/12 , 7/12 , 8/12 , 9/12 , 10/12 , 11/12 ,
    ]
```

## Typography

```css

    font-{sans , serif , mono }

    font-{  thin , extralight , light ,
            normal , medium ,
            semibold , bold , extrabold , black ,
    }

    antialiased /* font smoothing */
    subpixel-antialiased /* font smoothing */
    indent-{count} /* empty space shown before text in a block */

    italic
    non-italic

    text-{ xs , sm , base , lg , xl , (2-9)xl } /* size */
    text-{ left , center , right , justify } /* align */

    align-{ top , baseline , middle , bottom ,
            text-top , text-bottom , sub , super /* vertical align */
    }

    text-{ inherit , current , transparent , colors } /* color */

/* decoration */
    underline
    no-underline
    underline-offset-{ auto , 0 , 1 , 2 , 4 , 8 , }
    overline
    line-through
    decoration-{ 0 , 1 , 2 , 4 , 8 , auto , from-font } /* thickness */
    decoration-{colors} /* color */
    decoration-{ solid , double , dotted , dashed , wavy } /* style */

/* transform */
    uppercase
    lowercase
    capitalize
    normal-case

/* overflow */
    truncate
    text-ellipsis
    text-clip

/* whitespace  */
    whitespace-{ normal , nowrap , pre , pre-line , pre-wrap }

/* word break  */
    break-{ normal , words , all }

```

### Variant Numeric

```css
    normal-nums
    ordinal
    slashed-zero
    lining-nums
    oldstyle-nums
    proportional-nums
    tabular-nums
    diagonal-fractions
    stacked-fractions
```

### Letter spacing

```css
    tracking-tighter
    tracking-tight
    tracking-normal
    tracking-wide
    tracking-wider
    tracking-widest
```

### Line Height

```css
    leading-{ none , (3-10) , tight , snug , normal , relaxed , loose }
```

### List style

```css

    list-{ none disc , decimal } /* type */
    list-{ inside , outside }   /* position */


```

## Background

```css

    bg-{ fixed , local , scroll }

    bg-clip-{ border , padding , content , text } /* bounding box of an element's background. */

    bg-origin-{ border , padding , content }  /* positioned relative to borders, padding, and content. */

    bg-{ inherit , current , transparent , colors } /* color */

    bg-{ right ,left ,top ,bottom,center,
             right-{top,bottom}, left-{top,bottom}
       }

    bg-{ repeat , no-repeat , repeat-x , repeat-y , repeat-round , repeat-space }

    bg-{ auto , cover , contain } /* bg size */

    bg-{ none , gradiant-to-{ t , tr , tl , b , br , bl , r , l }  }
    >   from-{color} via-{color} to-{color}

```

## Borders & Effects

```css
    rounded-{breakpoints}
    border-{x , y , t, r ,l ,b }-{count}
    border-{color}
    border-{ solid , double , dotted , dashed , hidden , none }

    outline-{ 0 , 1 , 2 , 4 , 8 }
    outline-{color}
    outline-{ double , dotted , dashed , hidden }

    ring-{ 0 , 1 , 2 , 4 , 8 , inset }
    ring-{color}
    ring-offset-{ 0 , 1 , 2 , 4 , 8 }
    ring-offset-{ color }

    shadow-{breakpoints}
    shadow-{color}

    opacity-{%}

    mix-bend-{  normal , multiply , screen , overlay , darken , lighten ,
                difference , exclusion , hue , saturation , color , luminosity ,
                color-{ dodge , burn }
                {hard , soft }-light
            }
    bg-bend-{  normal , multiply , screen , overlay , darken , lighten ,
                difference , exclusion , hue , saturation , color , luminosity ,
                color-{ dodge , burn }
                {hard , soft }-light
            }

/* divider */
    divide-{ x-{count , reverse } , y-{count , reverse } }
    divide-{color}
    border-{ solid , double , dotted , dashed , none }


```

## Filters

```css
        blur-{brakpoints}
        brightness-{ 0-200 }
        contrast-{ 0-200 }
        drop-shadow-{ breakpoints }
        hue-rotate-{ 0-180 }
        saturate-{0-200}

        grayscale
        grayscale-0

        invert
        invert-0

        sepia
        sepia-0

        backdrop-blur-{brakpoints}
        backdrop-brightness-{ 0-200 }
        backdrop-contrast-{ 0-200 }
        backdrop-hue-rotate-{ 0-180 }
        backdrop-saturate-{0-200}
        backdrop-opacity-{%}

        backdrop-grayscale
        backdrop-grayscale-0

        backdrop-invert
        backdrop-invert-0

        backdrop-sepia
        backdrop-sepia-0
```
