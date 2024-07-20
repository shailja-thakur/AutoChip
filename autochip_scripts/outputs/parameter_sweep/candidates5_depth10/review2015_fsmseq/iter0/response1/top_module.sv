module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state;
	reg start_shifting;
	reg shift_enable;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else begin
			case (state)
				0: if (data == 1)
					   state <= 1;
				   else
					   state <= 0;
				1: if (data == 1)
					   state <= 2;
				   else
					   state <= 0;
				2: if (data == 0)
					   state <= 3;
				   else if (data == 1)
					   state <= 2;
				   else
					   state <= 0;
				3: if (data == 1)
					   state <= 4;
				   else if (data == 0)
					   state <= 3;
				   else
					   state <= 0;
				4: if (data == 1) begin
					   state <= 1;
					   start_shifting <= 1;
				   end
				   else if (data == 0)
					   state <= 3;
				   else
					   state <= 0;
			endcase
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			shift_enable <= 0;
		else begin
			if (state == 4)
				shift_enable <= 1;
			else
				shift_enable <= 0;
		end
	end

	assign start_shifting = shift_enable;


endmodule
