module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [7:0] shift_reg [2:0];
reg [7:0] next_shift_reg [2:0];
reg shift_reg_full;
reg done_reg;
reg [1:0] state;

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
		shift_reg_full <= 0;
		next_shift_reg <= 0;
		done_reg <= 0;
	end else begin
		case(state)
			2'b00:
				if (in[3] == 1) begin
					next_shift_reg[0] <= in;
					state <= 2'b01;
				end
			2'b01:
				if (in[3] == 1) begin
					next_shift_reg[1] <= in;
					state <= 2'b10;
				end else begin
					next_shift_reg[0] <= in;
					state <= 2'b00;
				end
			2'b10:
				if (in[3] == 1) begin
					next_shift_reg[2] <= in;
					shift_reg_full <= 1;
					state <= 2'b11;
				end else begin
					next_shift_reg[0] <= in;
					state <= 2'b00;
				end
			2'b11:
				if (in[3] == 1) begin
					next_shift_reg[0] <= in;
					state <= 2'b01;
				end
		endcase
	end
end

always @(posedge clk) begin
	if (reset) begin
		done <= 0;
	end else begin
		if (state == 2'b11 && shift_reg_full) begin
			done <= 1;
		end else begin
			done <= 0;
		end
	end
end

always @(posedge clk) begin
	if (reset) begin
		shift_reg_full <= 0;
	end else begin
		shift_reg_full <= 0;
		if (state == 2'b11) begin
			shift_reg_full <= 1;
			shift_reg[0] <= next_shift_reg[0];
			shift_reg[1] <= next_shift_reg[1];
			shift_reg[2] <= next_shift_reg[2];
		end
	end
end

endmodule
