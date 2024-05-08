module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);

    // The motor is on when the phone is in vibrate mode and the ring is not active.
    always @(posedge clk) begin
        if (vibrate_mode && !ring) begin
            motor <= 1;
        end else begin
            motor <= 0;
        end
    end

    // The ringer is on when the phone is not in vibrate mode and the ring is active.
    always @(posedge clk) begin
        if (!vibrate_mode && ring) begin
            ringer <= 1;
        end else begin
            ringer <= 0;
        end
    end

endmodule