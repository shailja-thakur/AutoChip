// Consider the function f shown in the Karnaugh map below.

// Implement this function. d is don't-care, which means you may choose to output whatever value is convenient.

         x_1'x_2'	x_1'x_2 	x_1x_2		x_1x_2'

x_3'x_4'	d		0		d		d
x_3'x_4		0		d		1		0
x_3x_4  	1		1		d		d
x_3x_4'		1		1		0		d


module top_module (
    input [4:1] x, 
    output f );

    // Insert your code here

endmodule

