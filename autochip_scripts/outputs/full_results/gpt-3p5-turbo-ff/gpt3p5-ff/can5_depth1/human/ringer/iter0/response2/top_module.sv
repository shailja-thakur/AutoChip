module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

reg ringer;
reg motor;

always @(ring, vibrate_mode) begin
	if (vibrate_mode == 1'b1) begin
		ringer <= 1'b0;
		motor <= 1'b1;
	end
	else begin
		ringer <= 1'b1;
		motor <= 1'b0;
	end
end

assign ringer = ringer;
assign motor = motor;

endmodule
