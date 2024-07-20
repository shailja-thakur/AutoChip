module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

	// Internal signal declarations
	reg [3:0] reg_data;

	// Shift register logic
	always @(posedge clk) begin
		if (shift_ena)
			reg_data <= {data, reg_data[3:1]};
	end

	// Down counter logic
	always @(posedge clk) begin
		if (count_ena)
			reg_data <= reg_data - 1;
	end

	// Assign output
	assign q = reg_data;

endmodule
