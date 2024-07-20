module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [3:0] count; // counter for tracking clock cycles
	
	// reset state
	always @(posedge clk) begin
		if (reset) begin
			shift_ena <= 1; // assert shift_ena
			count <= 0;
		end
		else begin
			shift_ena <= 0; // deassert shift_ena
			count <= count + 1;
		end
	end
	
	// enable state
	always @(posedge clk) begin
		if (count < 4) begin
			shift_ena <= 1; // assert shift_ena
			count <= count + 1;
		end
		else begin
			shift_ena <= 0; // deassert shift_ena
			count <= 0;
		end
	end
	
endmodule
