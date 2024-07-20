module top_module (
	input wire clk,
	input wire resetn,
	input wire in,
	output wire out
);

reg [3:0] data;
reg [3:0] next_data;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		data <= 4'b0;
	end else begin
		data <= next_data;
	end
end

always @(posedge clk) begin
	next_data[0] <= in;
	next_data[1] <= data[0];
	next_data[2] <= data[1];
	next_data[3] <= data[2];
end

assign out = data[3];

endmodule
