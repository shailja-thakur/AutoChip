module top_module (
	input clk,
	input x,
	output z
);

    reg q1, q2, q3;
    wire d1, d2, d3;
    wire xnor_out;

    // XOR gate
    assign d1 = x ^ q1;

    // AND gate
    assign d2 = x & ~q2;

    // OR gate
    assign d3 = x | ~q3;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // XNOR gate
    assign xnor_out = ~(q1 ^ q2 ^ q3);
    assign z = xnor_out;

endmodule
