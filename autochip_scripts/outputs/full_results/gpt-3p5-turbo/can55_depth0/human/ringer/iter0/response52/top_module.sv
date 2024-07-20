module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);

    reg ringer;
    reg motor;

    always @(*)
    begin
        if (vibrate_mode == 1)
        begin
            ringer <= 0;
            motor <= 1;
        end
        else
        begin
            ringer <= 1;
        end
    end

endmodule
