module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [1:0] state;
reg [23:0] data_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00;
		data_reg <= 24'b0;
		done <= 1'b0;
	end else begin
		case (state)
			2'b00: begin
				if (in[2]) state <= 2'b01;
				else state <= 2'b00;
			end

			2'b01: begin
				state <= 2'b10;
			end

			2'b10: begin
				if (in[2]) state <= 2'b11;
				else state <= 2'b00;
			end

			2'b11: begin
				state <= 2'b00;
			end
		endcase
	end
end

always @(posedge clk or posedge reset) begin
	if (reset) begin
		out_bytes <= 24'b0;
	end else begin
		if (done) begin
			out_bytes <= data_reg;
		end
	end
end

always @(posedge clk or posedge reset) begin
	if (reset) begin
		data_reg <= {in, in, in};
		done <= 1'b0;
	end else begin
		case (state)
			2'b00: begin
				data_reg <= {data_reg[23:8], in};
			end

			2'b01: begin
				data_reg <= {data_reg[23:8], in};
			end

			2'b10: begin
				data_reg <= {data_reg[23:8], in};
			end

			2'b11: begin
				data_reg <= {data_reg[23:8], in};
				done <= 1'b1;
			end
		endcase
	end
end

endmodule
