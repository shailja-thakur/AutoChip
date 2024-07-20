module top_module (
    input clk,
    input x,
    output z
);

// Declare D flip-flops
reg d1, d2, d3;

// Declare outputs of flip-flops
wire q1, q2, q3;

// Declare intermediate wires
wire xor_out, and_out, or_out;

// D flip-flop 1
always @(posedge clk) begin
    if (reset)
        d1 <= 1'b0;
    else
        d1 <= x;
end

// D flip-flop 2
always @(posedge clk) begin
    if (reset)
        d2 <= 1'b0;
    else
        d2 <= ~q1;
end

// D flip-flop 3
always @(posedge clk) begin
    if (reset)
        d3 <= 1'b0;
    else
        d3 <= ~q2;
end

// Outputs of the flip-flops
assign q1 = d1;
assign q2 = d2;
assign q3 = d3;

// XOR gate
assign xor_out = x ^ q1;

// AND gate
assign and_out = x & ~q2;

// OR gate
assign or_out = x | ~q3;

// XNOR gate
assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
