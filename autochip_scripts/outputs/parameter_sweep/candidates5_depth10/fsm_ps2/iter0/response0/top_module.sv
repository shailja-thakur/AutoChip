module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [7:0] curr_byte;
reg [7:0] prev_byte;
reg [7:0] prev_prev_byte;
reg done;
reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		done <= 0;
		state <= 0;
		prev_byte <= 0;
		prev_prev_byte <= 0;
	end else begin
		prev_prev_byte <= prev_byte;
		prev_byte <= curr_byte;
		curr_byte <= in;
		
		case (state)
			0: begin
				if (in[3] == 1) begin
					state <= 1;
				end
			end
			1: begin
				if (in[3] == 0) begin
					state <= 0;
				end else begin
					state <= 2;
				end
			end
			2: begin
				if (in[3] == 0) begin
					state <= 0;
				end else begin
					state <= 3;
				end
			end
			3: begin
				if (in[3] == 0) begin
					state <= 0;
				end else begin
					done <= 1;
					state <= 0;
				end
			end
			default: state <= 0;
		endcase
	end
end

endmodule
