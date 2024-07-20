module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Perform XOR operation and assign it to out_assign
    assign out_assign = a ^ b;

    // Always block for combinational logic, triggered by changes in a or b
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Always block for sequential logic, triggered on the rising edge of the clk
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
