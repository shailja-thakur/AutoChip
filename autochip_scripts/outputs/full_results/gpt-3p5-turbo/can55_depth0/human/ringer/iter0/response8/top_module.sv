module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
    output motor
);

// Complete the module definition
always @(ring, vibrate_mode) begin
    if (vibrate_mode == 1'b1) begin
        ringer <= 1'b0;
        motor <= 1'b1;
    end else begin
        ringer <= ring;
        motor <= 1'b0;
    end
end

endmodule
