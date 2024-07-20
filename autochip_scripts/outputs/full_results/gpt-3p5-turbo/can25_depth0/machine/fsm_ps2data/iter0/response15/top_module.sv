module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [1:0] state;
reg [23:0] out_bytes_reg;
reg done_reg;

always @(posedge clk or posedge reset) begin
	if (reset == 1'b1) begin
		state <= BYTE1;
		out_bytes_reg <= 0;
		done_reg <= 1'b0;
	end else begin
		case(state)
			BYTE1: begin
				if (in[2] == 1'b1) begin
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
				if (in[2] == 1'b0) begin
					state <= BYTE1;
				end else begin
					state <= BYTE1;
				end
			end
			
			default: begin
				state <= BYTE1;
			end
		endcase
		// Output updates on rising edge of clock
		if (state == DONE) begin
			out_bytes_reg <= in;
			done_reg <= 1'b1;
		end else begin
			out_bytes_reg <= {out_bytes_reg[15:0], in};
			done_reg <= 1'b0;
		end
	end
end

assign out_bytes = out_bytes_reg;
assign done = done_reg;
endmodule
