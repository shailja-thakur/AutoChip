module top_module(
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Perform XOR operation and assign the result to out_assign
    assign out_assign = a ^ b;
    
    // Always block to perform combinational logic
    always @(*) begin
        out_always_comb = out_assign;
    end
    
    // Always block for synchronous logic
    always @(posedge clk) begin
        out_always_ff = out_assign;
    end

endmodule
