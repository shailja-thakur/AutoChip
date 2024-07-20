module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [3:0] count;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			count <= 0;
			shift_ena <= 1;  // Assert shift_ena for 4 cycles during reset
		end else if (count != 4'b1111) begin
			count <= count + 1;
			shift_ena <= count == 4'b1110;  // Enable shift_ena for 4 clock cycles when bit pattern is detected
		end else begin
			shift_ena <= 0;  // Disable shift_ena after 4 clock cycles
		end
	end
endmodule
