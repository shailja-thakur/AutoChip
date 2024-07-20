module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

reg ringer;
reg motor;

always @(*) begin
    if (vibrate_mode)
        motor = 1;
    else if (ring)
        ringer = 1;
    else begin
        motor = 0;
        ringer = 0;
    end
end

endmodule
