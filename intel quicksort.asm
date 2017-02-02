; quick sort 
; by ShahroOz

; fill array with your data, 
; and N with the number of them

data segment
    N dw 9
    array dw 3,1,6,8,5,7,2,4,3
data ends

stack segment
    mystack db 100 dup(?)
stack ends

myprog segment
    main proc far
        assume cs: myprog, ds: data, ss: stack
        mov ax, data
        mov ds, ax
        lea sp, mystack+100
        
        lea si, array
        lea di, array
        add di, N
        add di, N
        sub di, 2
        call quicksort
        
        mov cx, N        
        mov bx, 0
   lll: mov ax, array[bx]
        add bx, 2
        loop lll
        
        hlt
        
    main endp
    
    partition proc near;input: is si=&array[l], di=&array[h], ret bx
        
        push ax
        ;push bx
        push cx
        push dx
        push di
        push si
        push sp
        
        mov ax, [di];ax as pivet   
        mov bx, si
        mov cx, di
        sub cx, si
        ;add cx, 2
 loop1: cmp [si], ax
        jg out1
        call swap; swap([si],[bx])
        add bx, 2
  out1: add si, 2
        sub cx, 2
        jnz loop1
        push si
        mov si, di
        call swap
        pop si
        
        pop sp
        pop si
        pop di
        pop dx
        pop cx
        ;pop bx
        pop ax
        
        ret
            
    partition endp
    
         swap proc near; swap([si],[bx])
             push ax;
             push dx;
             mov ax, [si]
             mov dx, [bx]
             mov [si], dx
             mov [bx], ax
             pop dx
             pop ax          
              
             ret
            
         swap endp
    quicksort proc near ; inputs: si=&array[0], di=array[n-1]
         
        push ax
        push bx
        push cx
        push dx
        push di
        push si
        push sp
        
        cmp si, di
        jl out2
        
        pop sp
        pop si
        pop di
        pop dx
        pop cx
        pop bx
        pop ax
        
        ret
        
  out2: call partition
        push di
        sub bx, 2
        mov di, bx
        call quicksort
        pop di
        add bx, 2
        push si
        mov si, bx
        call quicksort
        dec bx
        pop si
        
        
        pop sp
        pop si
        pop di
        pop dx
        pop cx
        pop bx
        pop ax
        
        ret                
        
    quicksort endp
    
myprog ends

        end main