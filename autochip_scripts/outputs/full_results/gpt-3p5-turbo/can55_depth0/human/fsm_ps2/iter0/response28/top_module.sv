module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg done_reg;
reg [7:0] byte_counter;
reg [7:0] byte_1;
reg [7:0] byte_2;
reg [7:0] byte_3;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		done_reg <= 0;
		byte_counter <= 0;
		byte_1 <= 0;
		byte_2 <= 0;
		byte_3 <= 0;
	end
	else begin
		case (state)
			0: begin
				if (in[3] == 1) begin
					byte_counter <= 1;
					byte_1 <= in;
					state <= 1;
				end
				else begin
					byte_1 <= in;
					state <= 0;
				end
			end
			1: begin
				byte_counter <= byte_counter + 1;
				byte_2 <= in;
				state <= 2;
			end
			2: begin
				byte_counter <= byte_counter + 1;
				byte_3 <= in;
				state <= 3;
			end
			3: begin
				byte_counter <= byte_counter + 1;
				done_reg <= 1;
				if (byte_counter == 3) begin
					byte_1 <= 0;
					byte_2 <= 0;
					byte_3 <= 0;
					state <= 0;
				end
				else begin
					state <= 2;
				end
			end
		endcase
	end
end

assign done = done_reg;

endmodule
