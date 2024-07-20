module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    assign out_assign = a ^ b; // XOR operation assigned directly

    // Combinational logic block
    always @(*) begin
        out_always_comb = a ^ b; // Use always block for combinational assignment
    end

    // Synchronous logic block
    always @(posedge clk) begin
        out_always_ff <= a ^ b; // Use always block for sequential assignment (synchronous with clk)
    end

endmodule
