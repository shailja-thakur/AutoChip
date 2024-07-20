module top_module (
	input clk,
	input in,
	output logic out
);

    logic xor_out;

    assign xor_out = in ^ out; // XOR gate
    always_ff @(posedge clk) begin
        out <= xor_out; // D Flip-Flop
    end
	
endmodule
