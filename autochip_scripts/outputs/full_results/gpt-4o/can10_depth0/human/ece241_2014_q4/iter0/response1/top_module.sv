module top_module (
	input clk,
	input x,
	output z
);
    // Intermediate signals for D flip-flops
    reg q1, q2, q3;
    
    // Wires for gate outputs
    wire xor_out, and_out, or_out;
    wire q1_n, q2_n, q3_n;

    // Complementary outputs of flip-flops
    assign q1_n = ~q1;
    assign q2_n = ~q2;
    assign q3_n = ~q3;

    // Gates
    assign xor_out = x ^ q1;
    assign and_out = x & q2_n;
    assign or_out = x | q3_n;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= xor_out;
        q2 <= and_out;
        q3 <= or_out;
    end

    // XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
