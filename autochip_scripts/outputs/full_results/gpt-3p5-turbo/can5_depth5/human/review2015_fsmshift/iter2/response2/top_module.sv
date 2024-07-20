module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] count;
	reg [1:0] state;
	reg [1:0] next_state;

	always @(posedge clk) begin
		if (reset) begin
			count <= 3'b0;
			state <= 2'b00;
			shift_ena <= 1'b1;
		end else begin
			count <= count + 1;
			state <= next_state;
		end
	end

	// FSM logic
	always @(state, count) begin
		case(state)
			2'b00: begin
				next_state <= 2'b01;
				shift_ena <= 1'b0;
			end
			2'b01: begin
				if (count == 3'b010) begin
					next_state <= 2'b10;
					shift_ena <= 1'b0;
					count <= 3'b0;
				end else begin
					next_state <= 2'b01;
					shift_ena <= 1'b0;
				end
			end
			2'b10: begin
				next_state <= 2'b11;
				shift_ena <= 1'b1;
			end
			2'b11: begin
				next_state <= 2'b00;
				shift_ena <= 1'b0;
			end
		endcase
	end

endmodule
