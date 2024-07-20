module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [1:0] state;

always @ (posedge clk or posedge reset) begin
	if (reset)
		state <= 2'b00;
	else begin
		case (state)
			2'b00: begin // Waiting for byte 1 of message
				if (in[3] == 1'b1) begin
					state <= 2'b01;
					out_bytes[23:16] <= in;
				end
			end
			2'b01: begin // Waiting for byte 2 of message
				state <= 2'b10;
				out_bytes[15:8] <= in;
			end
			2'b10: begin // Waiting for byte 3 of message
				state <= 2'b00;
				out_bytes[7:0] <= in;
				done <= 1'b1;
			end
		endcase
	end
end

always @ (posedge clk) begin
	if (reset)
		out_bytes <= 24'b0;
	else if (done)
		out_bytes <= 24'b0;
	else
		out_bytes <= {out_bytes[15:0], in};
end

endmodule
