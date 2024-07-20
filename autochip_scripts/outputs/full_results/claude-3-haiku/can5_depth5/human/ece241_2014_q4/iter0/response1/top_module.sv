module top_module (
    input clk,
    input x,
    output z
);

// Declare the D flip-flops
reg d1, d2, d3;
wire q1, q2, q3;

// Assign the flip-flop outputs
assign q1 = d1;
assign q2 = d2;
assign q3 = d3;

// Connect the input x to the gates
wire xor_out, and_out, or_out;
assign xor_out = x ^ q1;
assign and_out = x & ~q2;
assign or_out = x | ~q3;

// Connect the gates to the D flip-flops
always @(posedge clk) begin
    d1 <= xor_out;
    d2 <= and_out;
    d3 <= or_out;
end

// Connect the flip-flop outputs to the XNOR gate
assign z = ~(q1 ^ q2 ^ q3);

endmodule
