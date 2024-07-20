module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the XOR result of a and b to out_assign
    assign out_assign = a ^ b;
    
    // Combinational always block to update out_always_comb
    always @(*) begin
        out_always_comb = out_assign;
    end
    
    // Sequential always block to update out_always_ff on the rising edge of clk
    always @(posedge clk) begin
        out_always_ff = out_assign;
    end

endmodule
