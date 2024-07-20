module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] counter;
	reg shift_ena;

	always@(posedge clk or posedge reset) begin
		if(reset)
			counter <= 4'b0000;
		else if(counter == 4'b1011)
			counter <= 4'b0000;
		else if(counter != 4'b0000)
			counter <= counter + 4'b0001;
	end

	always@(posedge clk) begin
		if(counter == 4'b1010)
			shift_ena <= 1'b1;
		else
			shift_ena <= 1'b0;
	end

endmodule
