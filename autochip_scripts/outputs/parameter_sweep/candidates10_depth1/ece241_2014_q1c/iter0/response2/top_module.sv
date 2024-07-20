module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

reg [15:0] temp;
wire sign_a, sign_b, sign_temp, overflow;

assign sign_a = a[7];
assign sign_b = b[7];
assign sign_temp = temp[15];

always @* begin
	temp = a + b;
	
	if (sign_a == sign_b && sign_a != sign_temp)
		overflow = 1;
	else
		overflow = 0;
end

assign s = temp[7:0];

endmodule
