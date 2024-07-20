module top_module (
	input clk,
	input x,
	output z
);

	// Declare D flip flop inputs and outputs
	wire d1, d2, d3;
	wire q1, q2, q3;
	
	// Declare gate outputs
	wire xor_out, and_out, or_out;
	
	// Declare output wire z
	assign z = ~(q1 ^ q2 ^ q3);
	
	// Connect D flip flop inputs and outputs
	DFF dff1(clk, 1'b0, x, d1, q1);
	DFF dff2(clk, 1'b0, xor_out, d2, q2);
	DFF dff3(clk, 1'b0, and_out, d3, q3);
	
	// Connect gates to inputs and outputs
	xor gate_xor(x, q1, xor_out);
	and gate_and(x, ~q2, and_out);
	or gate_or(x, ~q3, or_out);
	
endmodule
module DFF (
    input clk,
    input rst,
    input d,
    output reg q
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule
module xor (
	input a,
	input b,
	output y
);
	xor u1 (y, a, b);
endmodule
module and (
	input a,
	input b,
	output y
);
	and u1 (y, a, b);
endmodule
module or (
	input a,
	input b,
	output y
);
	or u1 (y, a, b);
endmodule
