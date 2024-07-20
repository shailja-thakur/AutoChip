module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);
	
	// State transition logic
	always @*
	begin
		case(state)
			10'h001 -> next_state = 10'h001;
			10'h002 -> next_state = (in) ? 10'h003 : 10'h001;
			10'h003 -> next_state = (in) ? 10'h007 : 10'h001;
			10'h004 -> next_state = (in) ? 10'h009 : 10'h001;
			10'h005 -> next_state = (in) ? 10'h008 : 10'h00A;
			10'h006 -> next_state = (in) ? 10'h002 : 10'h001;
			10'h007 -> next_state = (in) ? 10'h007 : 10'h001;
			10'h008 -> next_state = (in) ? 10'h002 : 10'h001;
			10'h009 -> next_state = (in) ? 10'h002 : 10'h001;
			10'h00A -> next_state = (in) ? 10'h003 : 10'h001;
			default -> next_state = 10'h001;
		endcase
	end
	
	// Output logic
	assign out1 = (state == 10'h007) ? 1'b0 : 1'b0;
	assign out2 = (state == 10'h009 || state == 10'h00A) ? 1'b1 : 1'b0;
	
endmodule
