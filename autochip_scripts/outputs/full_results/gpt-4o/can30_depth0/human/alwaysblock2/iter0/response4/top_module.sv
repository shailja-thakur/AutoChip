module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // XOR using an assign statement
    assign out_assign = a ^ b;
    
    // XOR using a combinational always block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // XOR using a clocked always block (flip-flop)
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end
    
endmodule
