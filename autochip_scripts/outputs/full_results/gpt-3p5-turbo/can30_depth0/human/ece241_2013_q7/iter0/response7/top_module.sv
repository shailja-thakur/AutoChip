module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);

always @(posedge clk) begin
	if (j == 1 && k == 1)
		Q <= ~Q; // Toggle Q if both J and K are 1
	else if (j == 1 && k == 0)
		Q <= 1; // Set Q to 1 if J is 1 and K is 0
	else if (j == 0 && k == 1)
		Q <= 0; // Set Q to 0 if J is 0 and K is 1
	// else, do nothing (Q remains unchanged if both J and K are 0)
end

endmodule
