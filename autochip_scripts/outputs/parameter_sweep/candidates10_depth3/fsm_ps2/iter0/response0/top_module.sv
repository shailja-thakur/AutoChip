module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg done;
reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		byte1 <= 8'b0;
		byte2 <= 8'b0;
		byte3 <= 8'b0;
		done <= 0;
	end else begin
		case (state)
			0: begin // Idle state
				if (in[3] == 1'b1) begin
					byte1 <= in;
					state <= 1;
				end
			end
			1: begin // Received first byte
				if (in[3] == 1'b1) begin
					byte1 <= in;
				end else begin
					byte2 <= in;
					state <= 2;
				end
			end
			2: begin // Received second byte
				if (in[3] == 1'b1) begin
					byte1 <= in;
					state <= 1;
				end else begin
					byte3 <= in;
					state <= 3;
				end
			end
			3: begin // Received third byte
				if (in[3] == 1'b1) begin
					byte1 <= in;
					state <= 1;
				end else begin
					done <= 1;
					state <= 0;
				end
			end
		endcase
	end
end

endmodule
