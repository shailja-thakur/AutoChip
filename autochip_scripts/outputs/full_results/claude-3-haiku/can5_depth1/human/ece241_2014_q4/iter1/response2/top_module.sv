module top_module (
    input clk,
    input x,
    output z
);

reg q1, q2, q3;

// D flip-flops
always @(posedge clk) begin
    q1 <= x;
    q2 <= x;
    q3 <= x;
end

// Combinational logic
wire xor_out = x ^ q1;
wire and_out = x & ~q2;
wire or_out = x | q3;

// Three-input XNOR gate
assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
