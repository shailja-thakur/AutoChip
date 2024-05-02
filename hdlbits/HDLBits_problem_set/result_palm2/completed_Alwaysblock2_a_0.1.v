module top_module(
    input clk,
    input a,
    input b,
    output wire out_assign,
    output reg out_always_comb,
    output reg out_always_ff   );

    // Assign statement
    always @(posedge clk) begin
        out_assign = a ^ b;
    end

    // Combinational always block
    always @(a or b) begin
        out_always_comb = a ^ b;
    end

    // Clocked always block
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule