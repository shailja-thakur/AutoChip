module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
); 

reg [2:0] state;
reg [23:0] shift_reg;
wire third_bit;

assign third_bit = in[2];

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
		shift_reg <= 0;
	end else begin
		case (state)
			BYTE1: begin
				if (third_bit) begin
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
				if (third_bit) begin
					state <= BYTE1;
				end else begin
					state <= BYTE1;
				end
			end
			default: begin
				state <= BYTE1;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (done) begin
		out_bytes <= shift_reg;
	end else begin
		shift_reg <= {shift_reg[15:0], in};
	end
end

assign done = (state == DONE);

endmodule
