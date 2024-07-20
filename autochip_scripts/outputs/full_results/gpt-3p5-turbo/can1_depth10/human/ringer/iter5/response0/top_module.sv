module top_module(
    input wire ring, 
    input wire vibrate_mode,
    output reg ringer,
    output reg motor
);

always @(*) begin
    if (vibrate_mode == 1)
    begin
        motor = 1;
        ringer = 0;
    end
    else if (ring == 1)
    begin
        motor = 0;
        ringer = 1;
    end
    else
    begin
        motor = 0;
        ringer = 1;
    end
end

endmodule
