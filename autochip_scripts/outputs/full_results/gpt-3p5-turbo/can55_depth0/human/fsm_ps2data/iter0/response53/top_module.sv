module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [2:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg [23:0] out_data;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		byte1 <= 0;
		byte2 <= 0;
		byte3 <= 0;
		out_data <= 0;
	end else begin
		case (state)
			0: begin // search for byte with in[3] = 1
				if (in[3] == 1) begin
					state <= 1;
					byte1 <= in;
				end
			end
			1: begin // receive byte1, transition to state 2
				state <= 2;
				byte2 <= in;
			end
			2: begin // receive byte2, transition to state 3
				state <= 3;
				byte3 <= in;
			end
			3: begin // receive byte3, transition to state 0
				state <= 0;
				out_data <= {byte1, byte2, byte3};
			end
		endcase
	end
end

assign out_bytes = out_data;
assign done = (state == 3);

endmodule
