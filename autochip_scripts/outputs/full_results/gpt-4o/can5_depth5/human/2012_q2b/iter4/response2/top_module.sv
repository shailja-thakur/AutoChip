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

        // Y1 (input to state flip-flop y[1])
        if (y[0] && w == 1) begin
            Y1 = 1;
        end else begin
            Y1 = 0;
        end

        // Y3 (input to state flip-flop y[3])
        if ((y[1] && w == 0) || // B->D
            (y[2] && w == 0) || // C->D
            (y[3] && w == 0) || // D->A (but also assigns D for continuity)
            (y[4] && w == 0) || // E->D
            (y[5] && w == 0)) begin // F->D
            Y3 = 1;
        end else begin
            Y3 = 0;
        end
    end
endmodule
