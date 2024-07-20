module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the output of the XOR operation to out_assign
    assign out_assign = a ^ b;

    // Assign the output of the XOR operation to out_always_comb using an always block
    always @(a, b) begin
        out_always_comb = a ^ b;
    end

    // Assign the output of the XOR operation to out_always_ff using an always block triggered on the rising edge of clk
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
