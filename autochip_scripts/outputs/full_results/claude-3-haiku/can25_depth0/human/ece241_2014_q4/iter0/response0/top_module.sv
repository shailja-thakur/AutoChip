module top_module (
    input clk,
    input x,
    output z
);

reg Q1, Q2, Q3;

wire XOR_out, AND_out, OR_out;

// XOR gate
assign XOR_out = x ^ Q1;

// AND gate
assign AND_out = x & ~Q2;

// OR gate
assign OR_out = x | ~Q3;

// D flip-flops
always @(posedge clk) begin
    Q1 <= XOR_out;
    Q2 <= AND_out;
    Q3 <= OR_out;
end

// XNOR gate
assign z = ~(Q1 ^ Q2 ^ Q3);

endmodule
