module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [23:0] reg_out_bytes;
reg [2:0] state;
reg done;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		reg_out_bytes <= 0;
		state <= 0;
		done <= 0;
	end else begin
		case (state)
			0: begin // BYTE1 state
				if (in[2] == 1) begin
					state <= 1; // transition to BYTE2 state
				end else begin
					state <= 0; // stay at BYTE1 state
				end
			end
			1: begin // BYTE2 state
				state <= 2; // transition to BYTE3 state
			end
			2: begin // BYTE3 state
				state <= 3; // transition to DONE state
			end
			3: begin // DONE state
				if (in[2] == 0) begin
					state <= 0; // transition to BYTE1 state
				end else begin
					state <= 3; // stay at DONE state
				end
			end
			default: begin // default case to handle unforeseen state
				state <= 0;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (state == 3) begin // only update reg_out_bytes when in DONE state
		reg_out_bytes <= {reg_out_bytes[15:0], in}; // shift in the input into reg_out_bytes
	end
end

assign out_bytes = (done) ? reg_out_bytes : 0; // set out_bytes to reg_out_bytes when done is 1, otherwise set it to 0
assign done = (state == 3) ? 1 : 0; // set done to 1 when in DONE state, otherwise set it to 0

endmodule
