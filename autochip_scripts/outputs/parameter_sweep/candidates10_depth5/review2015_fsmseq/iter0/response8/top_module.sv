module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// State declaration
	reg [2:0] state;
	reg start_shifting;

	// Next state logic
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			state <= 3'b000;
		else
		begin
			case(state)
				3'b000: if (data) state <= 3'b001; else state <= 3'b000;
				3'b001: if (data) state <= 3'b010; else state <= 3'b000;
				3'b010: if (data) state <= 3'b011; else state <= 3'b000;
				3'b011: if (data) state <= 3'b100; else state <= 3'b000;
				3'b100: if (data) state <= 3'b101; else state <= 3'b000;
				3'b101: if (data) state <= 3'b110; else state <= 3'b000;
				3'b110: if (data) state <= 3'b111; else state <= 3'b000;
				3'b111: if (data) state <= 3'b111; else state <= 3'b000;
			endcase
		end
	end
	
	// Output logic
	always @(state)
	begin
		if (state == 3'b111)
			start_shifting <= 1'b1;
		else
			start_shifting <= 1'b0;
	end

endmodule
