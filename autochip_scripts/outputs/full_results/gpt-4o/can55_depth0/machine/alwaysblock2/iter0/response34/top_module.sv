module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

    // Perform the XOR operation and assign the result to out_assign
    assign out_assign = a ^ b;

    // Use an always block to assign the result to out_always_comb
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Use an always block triggered on the rising edge of clk to assign the result to out_always_ff
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
