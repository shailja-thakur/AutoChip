module top_module(
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    always @(*) begin
        out_assign = a ^ b;
        out_always_comb = out_assign;
    end
    
    reg [1:0] prev_a;
    reg [1:0] prev_b;
    
    always @(posedge clk) begin
        prev_a <= a;
        prev_b <= b;
        out_always_ff <= out_assign;
    end
    
endmodule
