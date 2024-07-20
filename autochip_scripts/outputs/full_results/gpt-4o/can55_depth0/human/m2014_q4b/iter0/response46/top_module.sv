module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);

always_ff @(posedge clk or posedge ar) begin
	if (ar) begin
		q <= 1'b0;  // Asynchronous reset
	end else begin
		q <= d;  // Capture the input 'd' on the rising edge of the clock
	end
end

endmodule
