module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

    // Using assign statement
    assign out_assign = a ^ b;
    
    // Using combinational always block
    always @(*) begin
        out_always_comb = a ^ b;
    end
    
    // Using clocked always block
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule
