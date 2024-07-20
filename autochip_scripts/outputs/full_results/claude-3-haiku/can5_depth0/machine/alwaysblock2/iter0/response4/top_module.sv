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

    // Always block for out_always_comb
    always @(a, b) begin
        out_always_comb = out_assign;
    end

    // Always block for out_always_ff
    always @(posedge clk) begin
        out_always_ff <= out_assign;
    end

endmodule
