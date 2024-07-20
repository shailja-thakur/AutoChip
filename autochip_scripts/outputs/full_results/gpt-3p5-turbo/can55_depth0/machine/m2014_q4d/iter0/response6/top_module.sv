module top_module (
	input clk,
	input in,
	output logic out
);

	// D flip-flop
    always_ff @(posedge clk) begin
        out <= in ^ out;
    end

endmodule
