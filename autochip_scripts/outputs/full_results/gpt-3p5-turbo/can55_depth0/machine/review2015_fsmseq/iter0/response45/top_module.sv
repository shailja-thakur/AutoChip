module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define states
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S11 = 2'b10;
	parameter S110 = 2'b11;
	parameter Done = 2'b00;

	reg [1:0] state;
	reg start_shifting;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= S;
		else begin
			case (state)
				S: begin
					if (data)
						state <= S1;
					else
						state <= S;
				end
				S1: begin
					if (data)
						state <= S11;
					else
						state <= S;
				end
				S11: begin
					if (data)
						state <= S11;
					else
						state <= S110;
				end
				S110: begin
					if (data)
						state <= Done;
					else
						state <= S;
				end
				Done: begin
					state <= Done;
				end
			endcase
		end
	end

	always @(state) begin
		start_shifting = (state == Done);
	end

endmodule
