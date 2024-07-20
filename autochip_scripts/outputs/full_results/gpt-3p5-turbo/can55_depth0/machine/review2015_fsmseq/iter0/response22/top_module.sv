module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// state parameters
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S11 = 2'b10;
	parameter S110 = 2'b11;
	parameter Done = 2'b00;

	// registers
	reg [1:0] state;
	reg start_shifting;

	// combinational logic
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= S;
		else begin
			case (state)
				S: if (data) state <= S1;
				   else state <= S;
				S1: if (data) state <= S11;
				    else state <= S;
				S11: if (data) state <= S11;
				     else state <= S110;
				S110: if (data) state <= Done;
				      else state <= S;
				Done: state <= Done;
			endcase
		end
	end

	// assign output
	always @ (state) begin
		if (state == Done)
			start_shifting <= 1'b1;
		else
			start_shifting <= 1'b0;
	end

endmodule
