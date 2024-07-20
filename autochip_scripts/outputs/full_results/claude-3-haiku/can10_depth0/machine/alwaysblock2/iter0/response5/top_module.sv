module top_module(
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Logical XOR operation
    assign out_assign = a ^ b;

    // Combinational logic using always block
    always @(a, b) begin
        out_always_comb = out_assign;
    end

    // Sequential logic using always block
    always @(posedge clk) begin
        out_always_ff <= out_assign;
    end

endmodule
