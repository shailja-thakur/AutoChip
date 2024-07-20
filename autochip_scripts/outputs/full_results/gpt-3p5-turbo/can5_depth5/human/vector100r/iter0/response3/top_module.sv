module top_module (
	input [99:0] in,
	output reg [99:0] out
);

// Use a wire to hold the reversed vector
wire [99:0] reversed_vector;

// Reverse the input vector using a for loop
integer i;
always @(*) begin
	for(i=0; i<100; i=i+1) begin
		reversed_vector[i] = in[99-i];
	end
end

// Assign the reversed vector to the output
assign out = reversed_vector;

endmodule
