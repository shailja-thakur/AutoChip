module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);

    always @(posedge clk) begin
        if (ring) begin
            if (vibrate_mode) begin
                motor = 1;
            else begin
                ringer = 1;
            end
        end
    end

endmodule