module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] data;
reg out;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		data <= 4'b0000;
	else begin
		data[0] <= in;
		data[1] <= data[0];
		data[2] <= data[1];
		data[3] <= data[2];
	end
end

assign out = data[3];

endmodule
