module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [2:0] state;
reg [23:0] out_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		out_reg <= 0;
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
				if (in[2] == 1) begin
					state <= 2;  // BYTE3
				end else begin
					state <= 0;  // BYTE1
				end
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
		out_reg <= {in, out_reg[15:0]};  // Shift in input and shift left by 8 bits
	end
end

assign out_bytes = out_reg;

assign done = (state == 3);

endmodule
