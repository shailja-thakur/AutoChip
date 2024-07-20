module top_module (
    input clk,
    input x,
    output z
);

reg d1, d2, d3;
reg q1, q2, q3;

// Combinational logic
wire xor_out = x ^ q1;
wire and_out = x & ~q2;
wire or_out = x | ~q3;

// D flip-flops
always @(posedge clk) begin
    q1 <= d1;
    q2 <= d2;
    q3 <= d3;
end

always @(*) begin
    d1 = xor_out;
    d2 = and_out;
    d3 = or_out;
end

// Output logic
assign z = ~(q1 ^ q2 ^ q3);

endmodule
