module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

// Instantiating full adders
genvar i;
generate
    for (i = 0; i < 4; i = i + 1) begin : adder_gen
        full_adder full_adder_inst (
            .a(x[i]),
            .b(y[i]),
            .cin(i == 0 ? 0 : sum[i]),
            .s(sum[i]),
            .cout(sum[i+1])
        );
    end
endgenerate

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output reg s,
	output reg cout
);

	always @(*) begin
		// Implementation of full adder logic
		s = a ^ b ^ cin;
		cout = (a & b) | (cin & (a ^ b));
	end

endmodule
