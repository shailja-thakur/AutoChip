module top_module(
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    assign out_assign = a ^ b; // XOR gate using assign statement

    always @* begin // Combinational always block
        out_always_comb = a ^ b;
    end

    always @(posedge clk) begin // Clocked always block
        out_always_ff <= a ^ b;
    end

endmodule
