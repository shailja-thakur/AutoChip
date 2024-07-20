module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

// Assign initial value to min as the maximum possible value
initial begin 
	min = 8'd255; 
end

// Compare a with min and update min if a is smaller
always @(a) begin
	if(a < min) begin
		min = a;
	end
end

// Compare b with min and update min if b is smaller
always @(b) begin
	if(b < min) begin
		min = b;
	end
end

// Compare c with min and update min if c is smaller
always @(c) begin
	if(c < min) begin
		min = c;
	end
end

// Compare d with min and update min if d is smaller
always @(d) begin
	if(d < min) begin
		min = d;
	end
end

endmodule
