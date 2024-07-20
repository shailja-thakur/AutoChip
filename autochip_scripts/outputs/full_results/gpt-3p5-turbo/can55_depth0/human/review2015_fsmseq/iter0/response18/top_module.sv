module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else begin
			case(state)
				0: if (data == 1'b1)
				       state <= 1;
				   else
				       state <= 0;
				1: if (data == 1'b1)
				       state <= 2;
				   else
				       state <= 0;
				2: if (data == 1'b0)
				       state <= 3;
				   else
				       state <= 0;
				3: if (data == 1'b1)
				       state <= 4;
				   else
				       state <= 0;
				4: state <= 5;
				5: state <= 0;
			endcase
		end
	end

	assign start_shifting = (state == 4);

endmodule
