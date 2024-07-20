module top_module (
    input clk,
    input x,
    output z
);

reg Q1, Q2, Q3;

// XOR gate
wire xor_out = x ^ Q1;

// AND gate
wire and_out = x & ~Q2;

// OR gate
wire or_out = x | ~Q3;

// D flip-flops
always @(posedge clk) begin
    Q1 <= xor_out;
    Q2 <= and_out;
    Q3 <= or_out;
end

// XNOR gate
assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
