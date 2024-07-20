module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] data;
reg out;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		data <= 4'b0;
		out <= 1'b0;
	end
	else begin
		data <= {data[2:0], in};
		out <= data[3];
	end
end

assign out = data[0];

endmodule
