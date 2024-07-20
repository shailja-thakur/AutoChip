module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

always_comb
begin
	case(state)
		2'b00:  // Current state A
		begin
			if(in) next_state = 2'b01;  // Next state B if input is high
			else next_state = 2'b00;  // Next state A if input is low
		end
		
		2'b01:  // Current state B
		begin
			if(in) next_state = 2'b01;  // Next state B if input is high
			else next_state = 2'b10;  // Next state C if input is low
		end
		
		2'b10:  // Current state C
		begin
			if(in) next_state = 2'b11;  // Next state D if input is high
			else next_state = 2'b00;  // Next state A if input is low
		end
		
		2'b11:  // Current state D
		begin
			if(in) next_state = 2'b01;  // Next state B if input is high
			else next_state = 2'b10;  // Next state C if input is low
		end
	endcase
end

assign out = (state == 2'b11);  // Output signal is high when in state D

endmodule
