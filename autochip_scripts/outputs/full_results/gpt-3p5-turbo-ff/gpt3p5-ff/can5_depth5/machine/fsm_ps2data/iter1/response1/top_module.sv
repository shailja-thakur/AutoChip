module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [2:0] state;
reg [23:0] out_reg;
reg done_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		out_reg <= 0;
		done_reg <= 0;
	end else begin
		case (state)
			0: begin  // BYTE1
				if (in[2] == 1) begin
					state <= 1;  // BYTE2
				end else begin
					state <= 0;  // BYTE1
				end
			end
			1: begin  // BYTE2
				state <= 2;  // BYTE3
			end
			2: begin  // BYTE3
				state <= 3;  // DONE
			end
			3: begin  // DONE
				if (in[2] == 0) begin
					state <= 0;  // BYTE1
				end else begin
					state <= 3;  // DONE
				end
			end
			default: begin
				state <= 0;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (state == 3) begin
		out_reg <= {in, out_reg[23:8]};  // Shift in input and shift left by 8 bits
	end
end

always @(posedge clk) begin
	if (state == 3) begin
		done_reg <= 1;  // Set done_reg to 1 when in DONE state
	end else begin
		done_reg <= 0;
	end
end

assign out_bytes = out_reg;
assign done = done_reg;

endmodule
