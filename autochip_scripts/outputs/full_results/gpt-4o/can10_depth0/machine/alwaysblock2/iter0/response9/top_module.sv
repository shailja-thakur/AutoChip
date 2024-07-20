module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Perform XOR operation
    assign out_assign = a ^ b;

    // Combinational logic block
    always @(*) begin
        out_always_comb = out_assign;
    end

    // Sequential logic block
    always @(posedge clk) begin
        out_always_ff = out_assign;
    end

endmodule
