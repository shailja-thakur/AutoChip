// 	In this module, x and y connect with top_module, which is a 3-bit vector.
	Y0 and z are two output ports.
	Inside the always_comb, it defines Y0 using a case statement.
	When {y[2:0],x}=4'h0, the output of Y0 is 0;
	When {y[2:0],x}=4'h1, the output of Y0 is 1;
	When {y[2:0],x}=4'h2, the output of Y0 is 1;
	When {y[2:0],x}=4'h3, the output of Y0 is 0;
	When {y[2:0],x}=4'h4, the output of Y0 is 0;
	When {y[2:0],x}=4'h5, the output of Y0 is 1;
	When {y[2:0],x}=4'h6, the output of Y0 is 1;
	When {y[2:0],x}=4'h7, the output of Y0 is 0;
	When {y[2:0],x}=4'h8, the output of Y0 is 1;
	When {y[2:0],x}=4'h9, the output of Y0 is 0;
	When {y[2:0],x} does not match any one of the above conditions, the output of Y0 is x;

	Inside the always_comb, it defines z using a case statement.
	When y[2:0]=3'h0, the output of z is 0;
	When y[2:0]=3'h1, the output of z is 0;
	When y[2:0]=3'h2, the output of z is 0;
	When y[2:0]=3'h3, the output of z is 1;
	When y[2:0]=3'h4, the output of z is 1;
	When y[2:0] does not match any one of the above conditions, the output of z is x;


module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);
