module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the result of the XOR operation to the out_assign port
    assign out_assign = a ^ b;

    // Assign the same value to the out_always_comb port using an always block
    always @(a, b) begin
        out_always_comb = a ^ b;
    end

    // Assign the same value to the out_always_ff port using an always block triggered on the rising edge of the clk port
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule
