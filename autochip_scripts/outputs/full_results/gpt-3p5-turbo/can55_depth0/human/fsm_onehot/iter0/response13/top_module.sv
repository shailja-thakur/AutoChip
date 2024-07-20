module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	/* Transition Logic */
	always @(*) begin
		case(state)
			10'b0000000001:
				if(in)
					next_state = 10'b0000000010;
				else
					next_state = 10'b0000000001;
			10'b0000000010:
				if(in)
					next_state = 10'b1000000001;
				else
					next_state = 10'b0000000011;
			10'b0000000011:
				if(in)
					next_state = 10'b0000000001;
				else
					next_state = 10'b0000000100;
			10'b0000000100:
				if(in)
					next_state = 10'b0000000001;
				else
					next_state = 10'b0000000101;
			10'b0000000101:
				if(in)
					next_state = 10'b0000001000;
				else
					next_state = 10'b0000000110;
			10'b0000000110:
				if(in)
					next_state = 10'b0000010010;
				else
					next_state = 10'b0000000111;
			10'b0000000111:
				if(in)
					next_state = 10'b0000000001;
				else
					next_state = 10'b0000001000;
			10'b0000001000:
				if(in)
					next_state = 10'b0000000001;
				else
					next_state = 10'b0000000010;
			10'b0000001001:
				if(in)
					next_state = 10'b0000000010;
				else
					next_state = 10'b0000000001;
			10'b0000001010:
				if(in)
					next_state = 10'b0000000000;
				else
					next_state = 10'b0000000100;
			default:
				next_state = 10'b0000000000;
		endcase
	end

	/* Output Logic */
	assign out1 = (state == 10'b0000001001) ? 1'b1 : 1'b0;
	assign out2 = (state == 10'b0000000111 || state == 10'b0000001010) ? 1'b1 : 1'b0;

endmodule
