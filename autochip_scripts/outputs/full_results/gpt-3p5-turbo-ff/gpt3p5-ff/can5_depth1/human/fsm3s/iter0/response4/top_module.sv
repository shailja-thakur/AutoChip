module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state, next_state;
	reg out_reg;

	always @(posedge clk) begin
		if (reset) begin
			state <= 2'b00; //{1'b0,1'b0};
		end
		else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			2'b00: begin
				if (in) begin
					next_state = 2'b10;
					out_reg = 1'b0;
				end else begin
					next_state = 2'b01;
					out_reg = 1'b0;
				end
			end

			2'b01:begin
				if (in) begin
					next_state = 2'b10;
					out_reg = 1'b0;
				end else begin
					next_state = 2'b01;
					out_reg = 1'b0;
				end
			end

			2'b10:begin
				if (in) begin
					next_state = 2'b11;
					out_reg = 1'b0;
				end else begin
					next_state = 2'b00;
					out_reg = 1'b0;
				end
			end

			2'b11:begin
				if (in) begin
					next_state = 2'b10;
					out_reg = 1'b1;
				end else begin
					next_state = 2'b01;
					out_reg = 1'b0;
				end
			end
		endcase
	end

	always @(posedge clk) begin
		out <= out_reg;
	end

endmodule
