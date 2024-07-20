module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

reg ringer, motor;

always @(*) begin
    if (vibrate_mode == 1)
        begin
            ringer <= 0;
            motor <= 1;
        end
    else
        begin
            ringer <= 1;
            motor <= 0;
        end
end

assign ringer = (vibrate_mode == 1) ? 0 : 1;
assign motor = (vibrate_mode == 1) ? 1 : 0;

endmodule
