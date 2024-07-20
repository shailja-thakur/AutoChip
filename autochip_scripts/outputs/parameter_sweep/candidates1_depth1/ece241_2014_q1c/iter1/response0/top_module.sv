module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output wire overflow
);

reg [8:0] sum;

// Adder
always @(a, b) begin
	sum = a + b;
end

// Assign output s
assign s = sum[7:0];

// Determine overflow
always @(sum) begin
	if (sum[8] != sum[7]) // Overflow if most significant bit and second most significant bit are different
		overflow <= 1;
	else
		overflow <= 0;
end

endmodule
