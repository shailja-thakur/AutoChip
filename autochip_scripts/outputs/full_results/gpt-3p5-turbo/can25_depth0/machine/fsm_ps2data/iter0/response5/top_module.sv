module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [7:0] input_reg;
	reg [23:0] out_reg;
	reg [1:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
			input_reg <= 8'b0;
			out_reg <= 24'b0;
		end else begin
			case (state)
				2'b00: begin
					if (in[2] == 1'b1) begin
						state <= 2'b01;
					end else begin
						state <= 2'b00;
					end
				end
				2'b01: begin
					state <= 2'b10;
				end
				2'b10: begin
					state <= 2'b11;
				end
				2'b11: begin
					state <= 2'b00;
				end
			endcase
			input_reg <= {in[6:0], 1'b0};
			out_reg <= out_reg << 8;
			
			if (state == 2'b11) begin
				out_bytes <= out_reg;
			end
		end
	end

	assign done = (state == 2'b11);

endmodule
