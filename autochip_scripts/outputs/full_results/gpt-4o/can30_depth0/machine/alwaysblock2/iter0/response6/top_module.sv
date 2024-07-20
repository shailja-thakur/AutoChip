module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

assign out_assign = a ^ b; // Logical XOR operation

always @(*) begin
    out_always_comb = a ^ b; // combinational always block
end

always @(posedge clk) begin
    out_always_ff <= a ^ b; // sequential always block, triggered on clk rising edge
end

endmodule
