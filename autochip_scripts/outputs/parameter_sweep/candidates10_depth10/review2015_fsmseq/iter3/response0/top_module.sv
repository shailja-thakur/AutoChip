module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg [3:0] next_state;
	reg [3:0] shift_reg;
	wire found_sequence;

	assign found_sequence = (shift_reg == 4'b1101);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
			start_shifting <= 0;
			shift_reg <= 4'b0000;
		end else begin
			state <= next_state;
			shift_reg <= {shift_reg[2:0], data};
			if (found_sequence) begin
				start_shifting <= 1;
			end else begin
				start_shifting <= 0;
			end
		end
	end

	always @(state or shift_reg) begin
		case (state)
			4'b0000: next_state = (shift_reg == 4'b1101) ? 4'b0011 : 4'b0001;
			4'b0001: next_state = (shift_reg[3:1] == 3'b110) ? 4'b0010 : 4'b0001;
			4'b0010: next_state = (shift_reg[2:0] == 3'b110) ? 4'b0011 : 4'b0001;
			4'b0011: next_state = (shift_reg[1:0] == 2'b11) ? 4'b0011 : 4'b0001;
		endcase
	end

endmodule
