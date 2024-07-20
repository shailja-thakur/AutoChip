module A(
	input x,
	input y,
	output z);

	assign z = (x^y) & x;

endmodule
module B(
	input x,
	input y,
	output z);

	reg z;

	always @(x or y)
	begin
		if(x==0 && y==0)
			z = 1;
		else if(x==1 && y==0)
			z = 0;
		else if(x==0 && y==1)
			z = 0;
		else if(x==1 && y==1)
			z = 1;
	end

endmodule
module top_module(
	input x,
	input y,
	output z);

	wire z1, z2;

	A A1(.x(x), .y(y), .z(z1));
	A A2(.x(x), .y(y), .z(z2));
	B B1(.x(x), .y(y), .z(z1));
	B B2(.x(x), .y(y), .z(z2));

	OR2X1 OR1(.in1(z1), .in2(z2), .out1(z));
	
endmodule
module OR2X1(
    input in1,
    input in2,
    output out1
);

    wire w1;

    assign w1=in1|in2;
    assign out1 = w1;

endmodule
module AND2X1(
	input in1,
	input in2,
	output out1
	);

	assign out1 = in1 & in2;

endmodule
module XOR2X1(
	input in1,
	input in2,
	output out1
	);

	assign out1 = in1 ^ in2;

endmodule
