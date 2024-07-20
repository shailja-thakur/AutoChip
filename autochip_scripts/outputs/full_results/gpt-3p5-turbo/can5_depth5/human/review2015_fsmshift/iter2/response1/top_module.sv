module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] count;
	reg [2:0] shift_ena_count;
	reg shift_ena;

	always @(posedge clk) begin
		if (reset) begin
			count <= 3'b0;
			shift_ena_count <= 3'b0;
		end else if (count == 3'b10) begin
			count <= 3'b0;
			shift_ena_count <= 3'b0;
			shift_ena <= 1'b0; // deassert shift_ena after 4 cycles
		end else if (shift_ena_count != 3'b11) begin
			count <= count + 1;
			shift_ena_count <= shift_ena_count + 1;
			shift_ena <= 1'b1; // assert shift_ena for 4 cycles
		end else begin
			count <= count + 1;
			shift_ena_count <= shift_ena_count + 1;
			shift_ena <= 1'b0; // deassert shift_ena after 4 cycles
		end
	end

endmodule
