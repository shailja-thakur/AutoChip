module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign XORED output directly
    assign out_assign = a ^ b;

    // Always block for combinational logic
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Always block for clocked logic (sequential)
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
