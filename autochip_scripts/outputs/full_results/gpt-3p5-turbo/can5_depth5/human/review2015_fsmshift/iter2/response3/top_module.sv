module top_module(
	input clk,
	input reset,
	output reg shift_ena
);

	reg [3:0] count;

	always @(posedge clk) begin
		if (reset) begin
			count <= 4'b0;
			shift_ena <= 1'b1; // assert shift_ena for 4 cycles during reset
		end else if (count < 4'b0011) begin
			count <= count + 1;
			shift_ena <= 1'b1; // assert shift_ena for 4 cycles
		end else begin
			count <= 4'b0;
			shift_ena <= 1'b0; // deassert shift_ena after 4 cycles
		end
	end

endmodule
