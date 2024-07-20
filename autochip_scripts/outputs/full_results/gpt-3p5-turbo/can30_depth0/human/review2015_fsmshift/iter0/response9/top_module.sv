module top_module(
	input clk,
	input reset,
	output shift_ena);

reg [2:0] state;
reg [2:0] nextState;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b000;
	else
		state <= nextState;
end

always @(state) begin
	case (state)
		3'b000: begin
			if (input_pattern_detected) begin
				nextState <= 3'b001;
				shift_ena <= 1'b1;
			end else begin
				nextState <= state;
				shift_ena <= 1'b0;
			end
		end
		3'b001: begin
			nextState <= 3'b010;
			shift_ena <= 1'b1;
		end
		3'b010: begin
			nextState <= 3'b011;
			shift_ena <= 1'b1;
		end
		3'b011: begin
			nextState <= 3'b000;
			shift_ena <= 1'b1;
		end
	endcase
end

endmodule
