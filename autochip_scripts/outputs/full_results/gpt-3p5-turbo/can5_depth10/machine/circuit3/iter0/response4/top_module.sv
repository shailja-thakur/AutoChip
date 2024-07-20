module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
	// Internal wires to store intermediate values
	wire ab_or;
	wire cd_or;

	// Compute bitwise OR of inputs a and b
	OR gate_ab(ab_or, a, b);

	// Compute bitwise OR of inputs c and d
	OR gate_cd(cd_or, c, d);

	// Compute bitwise AND of the two ORs
	AND gate_q(q, ab_or, cd_or);

endmodule
module OR (
    output reg out,
    input a,
    input b
);
	always @(*) begin
		out = a | b;
	end
endmodule
module AND (
    output reg out,
    input a,
    input b
);
	always @(*) begin
		out = a & b;
	end
endmodule
