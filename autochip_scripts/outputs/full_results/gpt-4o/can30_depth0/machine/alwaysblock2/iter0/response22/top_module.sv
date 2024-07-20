module top_module(
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Perform logical XOR operation on a and b and assign to out_assign
    assign out_assign = a ^ b;

    // Assign the same value to out_always_comb, triggered when a or b changes
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Assign the same value to out_always_ff, triggered on the rising edge of the clock
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
