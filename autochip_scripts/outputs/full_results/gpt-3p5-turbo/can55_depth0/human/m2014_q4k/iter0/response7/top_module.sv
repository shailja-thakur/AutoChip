module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] data; // shift register data

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		data <= 4'b0; // reset the data to 0
	else
		data <= {data[2:0], in}; // shift the data and store the input at the MSB
	end
end

assign out = data[0]; // output the LSB of the shift register

endmodule
