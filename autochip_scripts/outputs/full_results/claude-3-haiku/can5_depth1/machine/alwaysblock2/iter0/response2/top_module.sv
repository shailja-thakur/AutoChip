module top_module(
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Logical XOR operation on a and b
    assign out_assign = a ^ b;

    // Combinational logic block
    always @(a, b) begin
        out_always_comb = a ^ b;
    end

    // Sequential logic block
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule
