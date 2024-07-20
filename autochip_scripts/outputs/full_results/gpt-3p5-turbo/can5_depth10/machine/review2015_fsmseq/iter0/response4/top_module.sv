module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [2:0] state, next_state;
	parameter S = 3'b000;
	parameter S1 = 3'b001;
	parameter S11 = 3'b010;
	parameter S110 = 3'b011;
	parameter Done = 3'b100;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= S;
		else
			state <= next_state;
	end

	always @(state or data)
	begin
		case (state)
			S:
			begin
				if (data)
					next_state = S1;
				else
					next_state = S;
			end
			
			S1:
			begin
				if (data)
					next_state = S11;
				else
					next_state = S;
			end
			
			S11:
			begin
				if (data)
					next_state = S11;
				else
					next_state = S110;
			end
			
			S110:
			begin
				if (data)
					next_state = Done;
				else
					next_state = S;
			end
			
			Done:
			begin
				next_state = Done;
			end
		endcase
	end

	assign start_shifting = (state == Done) ? 1'b1 : 1'b0;

endmodule
