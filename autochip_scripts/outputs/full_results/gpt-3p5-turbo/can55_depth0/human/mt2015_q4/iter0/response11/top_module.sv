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
	
	always @(*) begin
		case({x, y})
			2'b00: z = 1'b1;
			2'b01: z = 1'b0;
			2'b10: z = 1'b0;
			2'b11: z = 1'b1;
		endcase
	end
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	A A1 (.x(x), .y(y), .z(a1));
	B B1 (.x(x), .y(y), .z(b1));
	A A2 (.x(x), .y(y), .z(a2));
	B B2 (.x(x), .y(y), .z(b2));
	
	or_gate or1 (.a(a1), .b(b1), .z(o1));
	and_gate and1 (.a(a2), .b(b2), .z(o2));
	xor_gate xor1 (.a(o1), .b(o2), .z(z));
	
endmodule
module or_gate(
	input a,
	input b,
	output z);
	
	assign z = a | b;
	
endmodule
module and_gate(
	input a,
	input b,
	output z);
	
	assign z = a & b;
	
endmodule
module xor_gate(
	input a,
	input b,
	output z);
	
	assign z = a ^ b;
	
endmodule
