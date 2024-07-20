module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Perform XOR operation and assign to out_assign
    assign out_assign = a ^ b;

    // Using always_comb block for combinational logic
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Using always_ff block for sequential logic
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
