module top_module (
	input clk,
	input in,
	output logic out
);

    logic xor_out;
    logic d_ff_out;

    xor2 xor_gate (.a(in), .b(out), .y(xor_out)); // two-input XOR gate

    always_ff @(posedge clk) begin
        d_ff_out <= xor_out;
        out <= d_ff_out;
    end

endmodule
