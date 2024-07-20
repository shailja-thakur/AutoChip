module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
	end else begin
		case (state)
			0: begin // Idle state
				if (in[3] == 1) begin
					byte1 <= in;
					state <= 1;
				end else begin
					state <= 0;
				end
			end
			1: begin // State 1 - First byte received
				byte2 <= in;
				state <= 2;
			end
			2: begin // State 2 - Second byte received
				byte3 <= in;
				state <= 3;
			end
			3: begin // State 3 - Done state
				out_bytes <= {byte1, byte2, byte3};
				state <= 0;
			end
		endcase
	end
end

assign done = (state == 3);

endmodule
