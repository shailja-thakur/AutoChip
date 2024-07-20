module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign out_assign using continuous assignment
    assign out_assign = a ^ b;

    // Assign out_always_comb using always_comb block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Assign out_always_ff using always_ff block triggered on the rising edge of the clock
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
