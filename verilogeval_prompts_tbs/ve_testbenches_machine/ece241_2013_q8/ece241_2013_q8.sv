// 	when the input x is 0, and the state is S, the state next is S. 
	when the input x is 1, and the state is S, the state next is S1.
	when the input x is 0, and the state is S1, the state next is S10. 
	when the input x is 1, and the state is S1, the state next is S1.
	when the input x is 0, and the state is S10, the state next is S. 
	when the input x is 1, and the state is S10, the state next is S1.
	
	when the input state is S, the output z is 0.
	when the input state is S1, the output z is 0.
	when the input state is S10, the output z is the input x.


module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
