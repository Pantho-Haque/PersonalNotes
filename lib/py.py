from tkinter import *

count = 0


def click():
    global count
    count += 1
    label.config(text=count)


window = Tk()
window.title("Pantho")

button = Button(window,
                text='click',
                command=click,
                font=('Ink Free', 50, 'bold'),
                bg='#ff6200',
                fg='#fffb1f',
                activebackground='#FF0000',
                activeforeground='#fffb1f'
                )

label = Label(window,
              text=count,
              font=('Monospace', 50)
              )

button.pack()
label.pack()
window.mainloop()
