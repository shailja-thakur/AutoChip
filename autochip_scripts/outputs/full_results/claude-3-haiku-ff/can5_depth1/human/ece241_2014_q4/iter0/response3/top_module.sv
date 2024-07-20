module top_module (
    input clk,
    input x,
    output z
);

// Declare the D flip-flops
reg d1, d2, d3;
wire q1, q2, q3;

// Assign the D flip-flop outputs
assign q1 = d1;
assign q2 = d2;
assign q3 = d3;

// Combinational logic
wire xor_out, and_out, or_out;

assign xor_out = x ^ q1;
assign and_out = x & ~q2;
assign or_out = x | ~q3;

// D flip-flop updates
always @(posedge clk) begin
    d1 <= xor_out;
    d2 <= and_out;
    d3 <= or_out;
end

// Output logic
assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
