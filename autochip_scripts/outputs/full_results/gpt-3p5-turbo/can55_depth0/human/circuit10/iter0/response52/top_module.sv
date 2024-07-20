module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

// Flip-flop
reg q_ff;
always @(posedge clk) begin
    q_ff <= a & b;
end

// Combinational logic
always @* begin
    state = a ^ b;
    q = q_ff;
end

endmodule
