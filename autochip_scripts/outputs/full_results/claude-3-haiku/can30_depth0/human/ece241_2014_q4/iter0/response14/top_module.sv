module top_module (
    input clk,
    input x,
    output z
);

reg q1, q2, q3;

wire xor_out, and_out, or_out;

// D flip-flop 1
always @(posedge clk) begin
    q1 <= x ^ q1;
end

// D flip-flop 2
always @(posedge clk) begin
    q2 <= x & ~q2;
end

// D flip-flop 3
always @(posedge clk) begin
    q3 <= x | ~q3;
end

// XOR gate
assign xor_out = x ^ q1;

// AND gate
assign and_out = x & ~q2;

// OR gate
assign or_out = x | ~q3;

// XNOR gate
assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
