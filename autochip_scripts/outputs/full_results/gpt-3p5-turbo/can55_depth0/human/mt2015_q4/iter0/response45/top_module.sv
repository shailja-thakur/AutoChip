module A(
	input x,
	input y,
	output z);

	assign z = (x ^ y) & x;

endmodule
module B(
	input x,
	input y,
	output z);

	reg z;

	always@(x or y)
	begin
		if(x == 0 && y == 0)
			z = 1;
		else if((x == 1 && y == 0) || (x == 0 && y == 1))
			z = 0;
		else
			z = 1;
	end

endmodule
module top_module(
	input x,
	input y,
	output z);

    wire a_z1, b_z1, a_z2, b_z2;
    wire or_out, and_out;
    
    A a1(.x(x), .y(y), .z(a_z1));
    B b1(.x(x), .y(y), .z(b_z1));
    A a2(.x(x), .y(y), .z(a_z2));
    B b2(.x(x), .y(y), .z(b_z2));
    
    or or_gate(.a(a_z1), .b(b_z1), .z(or_out));
    and and_gate(.a(a_z2), .b(b_z2), .z(and_out));
    xor xor_gate(.a(or_out), .b(and_out), .z(z));

endmodule
