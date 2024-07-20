module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);

    reg ringer_temp;
    reg motor_temp;

    always @(ring or vibrate_mode) begin
        if (vibrate_mode) begin
            ringer_temp <= 0;
            motor_temp <= 1;
        end else begin
            ringer_temp <= 1;
            motor_temp <= 0;
        end
    end

    always @(posedge ring or posedge vibrate_mode) begin
        ringer <= ringer_temp;
        motor <= motor_temp;
    end

endmodule
