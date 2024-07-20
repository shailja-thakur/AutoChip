module top_module(
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign port
    assign out_assign = a ^ b;

    // Always combinational block
    always @(a, b) begin
        out_always_comb = a ^ b;
    end

    // Always sequential block
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule
