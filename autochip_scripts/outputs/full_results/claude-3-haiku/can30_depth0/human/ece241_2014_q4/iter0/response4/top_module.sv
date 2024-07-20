module top_module (
    input clk,
    input x,
    output z
);

reg q1, q2, q3;

// XOR gate
wire x_xor = x ^ q1;

// AND gate
wire x_and = x & ~q2;

// OR gate
wire x_or = x | ~q3;

// D flip-flops
always @(posedge clk) begin
    q1 <= x_xor;
    q2 <= x_and;
    q3 <= x_or;
end

// XNOR gate
assign z = ~(q1 ^ q2 ^ q3);

endmodule
