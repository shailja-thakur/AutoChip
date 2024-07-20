module top_module (
	input clk,
	input in,
	output logic out
);

    logic xor_out;

    always_ff @(posedge clk) begin
        out <= xor_out;
    end

    assign xor_out = in ^ out;

endmodule
