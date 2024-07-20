module top_module(
	input wire clk,
	input wire load,
	input wire [9:0] data,
	output wire tc
);

reg [9:0] counter;

always @(posedge clk)
begin
	if (load)
		counter <= data;
	else if (counter != 0)
		counter <= counter - 1;
	
	tc <= (counter == 0);
end

endmodule
