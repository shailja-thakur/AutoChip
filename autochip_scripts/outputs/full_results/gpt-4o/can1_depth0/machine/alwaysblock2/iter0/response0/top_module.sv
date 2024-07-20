module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);
    
    // Assign out_assign with the XOR of a and b
    assign out_assign = a ^ b;

    // Combinational always block for out_always_comb
    always @* begin
        out_always_comb = out_assign;
    end

    // Synchronous always block for out_always_ff
    always @(posedge clk) begin
        out_always_ff = out_assign;
    end

endmodule
