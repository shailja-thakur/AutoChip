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

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
		byte1 <= 0;
		byte2 <= 0;
		byte3 <= 0;
	end else begin
		case (state)
			0: begin // Wait for in[3] to be 1
				if (in[3]) begin
					byte1 <= in;
					state <= 1;
				end
			end
			1: begin // Receive second byte
				byte2 <= in;
				state <= 2;
			end
			2: begin // Receive third byte and output message
				byte3 <= in;
				state <= 3;
			end
			3: begin // Output message and go back to waiting state
				out_bytes[23:16] <= byte1;
				out_bytes[15:8] <= byte2;
				out_bytes[7:0] <= byte3;
				state <= 0;
			end
		endcase
	end
end

assign done = (state == 3);

endmodule
