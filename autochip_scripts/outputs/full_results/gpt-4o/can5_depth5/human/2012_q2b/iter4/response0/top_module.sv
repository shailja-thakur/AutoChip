module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

    always @(*) begin
        // Default assignments
        Y1 = 0;
        Y3 = 0;

        // Y1 is the input to the flip-flop for state B (y[1])
        if (y[0] && w) begin
            Y1 = 1;
        end

        // Y3 is the input to the flip-flop for state D (y[3])
        if ( (y[1] && !w)      || // B to D
             (y[2] && !w)      || // C to D
             (y[3] && !w)      || // D to D
             (y[4] && !w)      || // E to D
             (y[5] && !w) ) begin // F to D
            Y3 = 1;
        end
    end
    
endmodule
