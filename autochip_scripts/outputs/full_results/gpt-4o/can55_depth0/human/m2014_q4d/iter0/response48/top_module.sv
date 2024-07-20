module top_module (
	input clk,
	input in,
	output logic out
);

    wire xor_out;
    assign xor_out = in ^ out;

    always_ff @(posedge clk) begin
        out <= xor_out;
    end

endmodule
