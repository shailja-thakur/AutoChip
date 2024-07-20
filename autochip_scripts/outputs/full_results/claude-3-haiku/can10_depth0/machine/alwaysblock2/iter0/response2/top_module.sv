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

    // Assign out_always_comb using combinational logic
    always @(a, b) begin
        out_always_comb = out_assign;
    end

    // Assign out_always_ff using synchronous logic
    always @(posedge clk) begin
        out_always_ff = out_assign;
    end

endmodule
