module top_module (
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the result of XOR operation to out_assign
    assign out_assign = a ^ b;

    // Assign using always block triggered by changes in a or b
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Assign using always block triggered by the rising edge of clk
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
