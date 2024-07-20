module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [7:0] state;
reg [23:0] temp_out_bytes;

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
	end else begin
		case (state)
			0: begin // waiting for message start
				if (in[3] == 1) begin
					state <= 1;
					temp_out_bytes <= in;
				end
			end
			1: begin // received first byte
				state <= 2;
				temp_out_bytes <= {temp_out_bytes[15:0], in};
			end
			2: begin // received second byte
				state <= 3;
				temp_out_bytes <= {temp_out_bytes[7:0], in};
			end
			3: begin // received third byte
				state <= 0;
				temp_out_bytes <= {temp_out_bytes[15:0], in};
			end
			default: begin
				state <= 0;
				temp_out_bytes <= 0;
			end
		endcase
	end
end

assign out_bytes = (state == 3) ? temp_out_bytes : 0;
assign done = (state == 3);

endmodule
