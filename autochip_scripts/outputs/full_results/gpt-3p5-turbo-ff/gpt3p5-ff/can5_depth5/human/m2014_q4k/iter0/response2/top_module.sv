module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] data;

// Implement D flip-flops
always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		data <= 4'b0; // Asynchronous reset
	else
		data <= {data[2:0], in}; // Shift the data
	end
end

assign out = data[3];

endmodule
