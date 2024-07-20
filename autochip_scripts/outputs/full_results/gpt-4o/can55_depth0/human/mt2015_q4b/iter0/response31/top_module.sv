module top_module(
    input x,
    input y,
    output reg z);

    always @(*) begin
        // By analyzing the waveform, we notice that:
        // z = 1 when (x == 0 and y == 0) or (x == 1 and y == 1)
        // z = 0 otherwise
        if ((x == 0 && y == 0) || (x == 1 && y == 1))
            z = 1;
        else
            z = 0;
    end

endmodule
