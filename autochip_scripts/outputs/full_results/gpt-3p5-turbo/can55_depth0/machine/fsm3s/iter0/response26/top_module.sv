module top_module (
	input clk,
	input in,
	input reset,
	output [1:0] state_out
);

reg [1:0] state_reg;
reg [1:0] state_next;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state_reg <= 2'b00; // initial state A
	end else begin
		state_reg <= state_next;
	end
end

always @(state_reg or in) begin
	case (state_reg)
		0 : begin // state A
			if (in) begin
				state_next = 2'b01; // transition to state B
			end else begin
				state_next = 2'b00; // remain in state A
			end
		end
		1 : begin // state B
			if (in) begin
				state_next = 2'b01; // remain in state B
			end else begin
				state_next = 2'b10; // transition to state C
			end
		end
		2 : begin // state C
			if (in) begin
				state_next = 2'b11; // transition to state D
			end else begin
				state_next = 2'b00; // transition to state A
			end
		end
		3 : begin // state D
			if (in) begin
				state_next = 2'b01; // transition to state B
			end else begin
				state_next = 2'b10; // transition to state C
			end
		end
		default : begin
			state_next = 2'b00;
		end
	endcase
end

assign out = (state_reg == 2'b11); // set out to 1 when state is D
assign state_out = state_reg;

endmodule
