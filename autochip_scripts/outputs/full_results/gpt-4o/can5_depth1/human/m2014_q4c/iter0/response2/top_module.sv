module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

always_ff @(posedge clk) begin
    if (r) begin
        q <= 1'b0; // Reset the output to 0 if reset is high
    end else begin
        q <= d; // Capture the value of d at the positive edge of the clock
    end
end

endmodule
