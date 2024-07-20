module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

// Combinational logic for out_assign
assign out_assign = a ^ b;

// Combinational logic for out_always_comb
always @(a, b) begin
    out_always_comb = a ^ b;
end

// Sequential logic for out_always_ff
always @(posedge clk) begin
    out_always_ff <= a ^ b;
end

endmodule
