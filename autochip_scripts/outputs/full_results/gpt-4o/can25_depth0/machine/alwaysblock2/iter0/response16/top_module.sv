module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the result of a XOR b to out_assign
    assign out_assign = a ^ b;
    
    // Always block for out_always_comb, triggered whenever a or b changes
    always @(*) begin
        out_always_comb = a ^ b;
    end
    
    // Always block for out_always_ff, triggered on the rising edge of clk
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
