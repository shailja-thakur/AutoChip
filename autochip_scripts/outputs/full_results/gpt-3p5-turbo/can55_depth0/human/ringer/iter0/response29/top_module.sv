module top_module(
    input ring,
    input vibrate_mode,
    output reg ringer,
    output reg motor
);

always @*
begin
    if (vibrate_mode == 1)
    begin
        ringer = 0;
        motor = 1;
    end
    else
    begin
        ringer = 1;
        motor = 0;
    end
end

endmodule
