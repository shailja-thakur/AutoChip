module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	/* Add variables to store the previous input */
	reg prev_in;

	reg [2:0] state;
	assign disc = (state == 2'b10);
	assign flag = (state == 3'b100);
	assign err = (state == 3'b101);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
		end else begin
			case (state)
				0: if (in) state <= 1;
				   else state <= 0;
				1: if (in) state <= 2;
				   else state <= 0;
				2: if (in) state <= 3;
				   else state <= 4;
				3: if (in) state <= 3;
				   else state <= 0;
				4: if (in) state <= 5;
				   else state <= 0;
				5: if (in) state <= 6;
				   else state <= 0;
				6: if (in) state <= 3;
				   else state <= 7;
				7: state <= 0;
				default: state <= 0;
			endcase
		end

		/* Store the current input for the next cycle */
		prev_in <= in;
	end

	/* Add initial value assignment for prev_in */
	initial begin
		prev_in <= 1'b0;
	end

	/* Add a sensitivity list for prev_in to check for errors */
	always @(posedge clk) begin
		if (prev_in && in) begin
			state <= 3'b101;
		end
	end

endmodule
