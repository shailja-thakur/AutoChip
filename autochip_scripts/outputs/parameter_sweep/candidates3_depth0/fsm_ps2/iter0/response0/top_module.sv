module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] byte_count;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		byte_count <= 0;
	end else begin
		case(state)
			0: begin // Waiting for first byte
				if (in[3]) begin
					state <= 1;
					byte_count <= 1;
				end
			end
			1: begin // Waiting for second byte
				state <= 2;
				byte_count <= byte_count + 1;
			end
			2: begin // Waiting for third byte
				state <= 0;
				byte_count <= byte_count + 1;
			end
		endcase
	end
end

assign done = (byte_count == 3);

endmodule
