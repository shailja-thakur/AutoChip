module a_module(
	input x,
	input y,
	output z);

	assign z = (x ^ y) & x;

endmodule
module b_module(
	input x,
	input y,
	output z);

	reg z;

	always @(*)
		begin
			case({x, y})
				2'b00: z = 1'b1;
				2'b01: z = 1'b0;
				2'b10: z = 1'b0;
				2'b11: z = 1'b1;
				default: z = 1'b0;
			endcase
		end

endmodule
module top_module(
	input x,
	input y,
	output z);

	wire a_z1, a_z2, b_z1, b_z2;
	wire or_out, and_out, xor_out;

	a_module a1(.x(x), .y(y), .z(a_z1));
	a_module a2(.x(x), .y(y), .z(a_z2));

	b_module b1(.x(x), .y(y), .z(b_z1));
	b_module b2(.x(x), .y(y), .z(b_z2));

	or_gate or1(.a(a_z1), .b(b_z1), .z(or_out));
	and_gate and1(.a(a_z2), .b(b_z2), .z(and_out));
	xor_gate xor1(.a(or_out), .b(and_out), .z(z));

endmodule
module or_gate(
     input a,
     input b,
     output z
     );

     assign z = a | b;

endmodule
module and_gate(
     input a,
     input b,
     output z
     );
     
     assign z = a & b;

endmodule
module xor_gate(
     input a,
     input b,
     output z
     );

     assign z = a ^ b;

endmodule
