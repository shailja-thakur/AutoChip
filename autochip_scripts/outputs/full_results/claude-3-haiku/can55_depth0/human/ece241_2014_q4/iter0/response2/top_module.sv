module top_module (
    input clk,
    input x,
    output z
);

reg q1, q2, q3;

wire xor_out, and_out, or_out;

// XOR gate
assign xor_out = x ^ q1;

// AND gate
assign and_out = x & ~q2;

// OR gate
assign or_out = x | ~q3;

// D Flip-flops
always @(posedge clk) begin
    q1 <= xor_out;
    q2 <= and_out;
    q3 <= or_out;
end

// XNOR gate
assign z = ~(q1 ^ q2 ^ q3);

endmodule
