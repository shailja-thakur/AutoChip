module top_module(
	input clk,
	input reset,
	output shift_ena
);

reg [3:0] count;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		count <= 4'b0;
		shift_ena <= 1'b1;
	end else begin
		if (count == 4'b1111) begin
			count <= 4'b0;
			shift_ena <= 1'b0;
		end else begin
			count <= count + 1'b1;
			shift_ena <= 1'b1;
		end
	end
end

endmodule
