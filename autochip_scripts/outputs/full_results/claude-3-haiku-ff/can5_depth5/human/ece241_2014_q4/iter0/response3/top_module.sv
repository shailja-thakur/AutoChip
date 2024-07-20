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

// Three-input XNOR gate
assign z = ~(xor_out ^ and_out ^ or_out);

// D flip-flop 1
always @(posedge clk) begin
    q1 <= xor_out;
end

// D flip-flop 2
always @(posedge clk) begin
    q2 <= and_out;
end

// D flip-flop 3
always @(posedge clk) begin
    q3 <= or_out;
end

endmodule
