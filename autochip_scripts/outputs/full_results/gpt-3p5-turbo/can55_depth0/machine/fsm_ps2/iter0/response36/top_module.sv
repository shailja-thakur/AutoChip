module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
wire bit3;
assign bit3 = in[2];

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
	end else begin
		case (state)
			BYTE1: begin
				if (bit3) begin
					state <= BYTE2;
				end else begin
					state <= BYTE1;
				end
			end
			BYTE2: begin
				state <= BYTE3;
			end
			BYTE3: begin
				state <= DONE;
			end
			DONE: begin
				if (bit3) begin
					state <= BYTE2;
				end else begin
					state <= BYTE1;
				end
			end
		endcase
	end
end

assign done = (state == DONE);

endmodule
