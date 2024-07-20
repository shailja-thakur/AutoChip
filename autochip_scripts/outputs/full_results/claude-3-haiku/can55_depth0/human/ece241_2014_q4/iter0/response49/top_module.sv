module top_module (
    input clk,
    input x,
    output z
);

reg q1, q2, q3;

// XOR gate
wire xor_out = x ^ q1;

// AND gate
wire and_out = x & ~q2;

// OR gate
wire or_out = x | ~q3;

// XNOR gate
assign z = ~(xor_out ^ and_out ^ or_out);

always @(posedge clk) begin
    q1 <= xor_out;
    q2 <= and_out;
    q3 <= or_out;
end

endmodule
