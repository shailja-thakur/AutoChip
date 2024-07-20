module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

	reg [7:0] byte_1, byte_2, byte_3;
	reg reset_done;

	always @(posedge clk) begin
		if (reset) begin
			reset_done <= 0;
			byte_1 <= 0;
			byte_2 <= 0;
			byte_3 <= 0;
		end else begin
			if (reset_done) begin
				byte_1 <= byte_2;
				byte_2 <= byte_3;
				byte_3 <= in;
			end else begin
				byte_1 <= in;
				byte_2 <= 0;
				byte_3 <= 0;
				if (in[3]) begin
					reset_done <= 1;
				end
			end
		end
	end

	assign done = reset_done;

endmodule
