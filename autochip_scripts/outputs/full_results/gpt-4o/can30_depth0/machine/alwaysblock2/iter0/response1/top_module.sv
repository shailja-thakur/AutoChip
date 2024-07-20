module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Output assignment using continuous assignment
    assign out_assign = a ^ b;

    // Output assignment using always_comb block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Output assignment using always_ff block
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
