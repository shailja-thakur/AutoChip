module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

reg [9:0] internal_counter;

always @(posedge clk) begin
	if (load)
		internal_counter <= data;
	else if (internal_counter > 0)
		internal_counter <= internal_counter - 1;
end

assign tc = (internal_counter == 0);

endmodule
