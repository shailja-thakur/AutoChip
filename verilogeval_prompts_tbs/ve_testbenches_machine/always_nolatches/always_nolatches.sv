// Scancode is the 16-bit scancode that is input from the keyboard through the USB cable. 
UP, left, down, and right are the binary results of up, left, down, and right arrows pressed on the keyboard respectively. 

If the 16-bit scancode is equal to 16'he06b, then the left is equal to 1, else the left is equal to 0.
If the 16-bit scancode is equal to 16'he072, then the down is equal to 1, else the down is equal to 0.
If the 16-bit scancode is equal to 16'he074, then the right is equal to 1, else the right is equal to 0.
If the 16-bit scancode is equal to 16'he075, then the up is equal to 1, else the up is equal to 0.

The 16-bit scancode is input to the module through the USB cable and then depending on the scancode value, the UP, left, down, and right are set to 1.



module top_module (
	input [15:0] scancode,
	output reg left,
	output reg down,
	output reg right,
	output reg up
);
