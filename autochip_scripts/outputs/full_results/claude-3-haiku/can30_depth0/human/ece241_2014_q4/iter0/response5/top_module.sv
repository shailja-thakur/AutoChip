module top_module (
    input clk,
    input x,
    output z
);

reg q1, q2, q3;

wire x_xor_q1, x_and_q1, x_or_q1;
wire x_xor_q2, x_and_q2, x_or_q2;
wire x_xor_q3, x_and_q3, x_or_q3;

// D flip-flop updates
always @(posedge clk) begin
    q1 <= x_xor_q1;
    q2 <= x_xor_q2;
    q3 <= x_xor_q3;
end

// Combinational logic
assign x_xor_q1 = x ^ q1;
assign x_and_q1 = x & ~q1;
assign x_or_q1 = x | ~q1;

assign x_xor_q2 = x ^ q2;
assign x_and_q2 = x & ~q2;
assign x_or_q2 = x | ~q2;

assign x_xor_q3 = x ^ q3;
assign x_and_q3 = x & ~q3;
assign x_or_q3 = x | ~q3;

// Output logic
assign z = ~(x_xor_q1 ^ x_xor_q2 ^ x_xor_q3);

endmodule
