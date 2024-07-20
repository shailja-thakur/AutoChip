module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Perform XOR operation and assign result to out_assign
    assign out_assign = a ^ b;

    // Update out_always_comb with the result of the XOR operation
    always @(*) begin
        out_always_comb = out_assign;
    end

    // Update out_always_ff with the result of the XOR operation on the rising edge of clk
    always @(posedge clk) begin
        out_always_ff = out_assign;
    end

endmodule
