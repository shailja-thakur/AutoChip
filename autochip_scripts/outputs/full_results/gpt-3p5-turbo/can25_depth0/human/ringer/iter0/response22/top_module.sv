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
            ringer = 0;
            motor = 0;
        end
    end
    
    assign motor = ~ringer;
    assign ringer = ~motor;

endmodule
