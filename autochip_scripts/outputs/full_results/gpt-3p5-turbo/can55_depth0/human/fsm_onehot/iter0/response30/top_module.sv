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
			10'b0000_0001:
				if(in)
					next_state = 10'b0000_0010;
				else
					next_state = 10'b0000_0001;
			
			10'b0000_0010:
				if(in)
					next_state = 10'b0000_0100;
				else
					next_state = 10'b0000_0001;
			
			10'b0000_0100:
				if(in)
					next_state = 10'b0000_1000;
				else
					next_state = 10'b0000_0001;
			
			10'b0000_1000:
				if(in)
					next_state = 10'b0001_0000;
				else
					next_state = 10'b0000_0100;
			
			10'b0001_0000:
				if(in)
					next_state = 10'b0010_0000;
				else
					next_state = 10'b0000_0001;
			
			10'b0010_0000:
				if(in)
					next_state = 10'b0000_0001;
				else
					next_state = 10'b0000_0001;
			
			10'b0010_0001:
				if(in)
					next_state = 10'b0000_0001;
				else
					next_state = 10'b0000_0001;
			
			10'b0000_0000:
				if(in)
					next_state = 10'b0000_0010;
				else
					next_state = 10'b0000_0001;
			
			10'b0000_0011:
				if(in)
					next_state = 10'b0000_0100;
				else
					next_state = 10'b0000_0001;
			
			default:
				next_state = 10'b0000_0000;
		endcase
	end

	// Output logic
	assign out1 = (state == 10'b0010_0000 || state == 10'b0010_0001 || state == 10'b0000_0000 || state == 10'b0000_0011) ? 1'b0 : 1'b0;
	assign out2 = (state == 10'b0010_0001 || state == 10'b0000_0000) ? 1'b1 : 1'b0;

endmodule
