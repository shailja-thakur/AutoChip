module top_module(
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

// Declare internal wire for XOR operation
wire xor_result;

assign out_assign = xor_result;

// Combinational always block
always @* begin
    out_always_comb = xor_result;
end

// Synchronous always block
always @(posedge clk) begin
    out_always_ff <= xor_result;
end

// XOR gate
assign xor_result = a ^ b;

endmodule
