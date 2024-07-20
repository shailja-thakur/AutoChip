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
        // Transition A(000001) --1--> B(000010)
        if (y == 6'b000001 && w == 1) begin
            Y1 = 1;
        end

        // Y3 is the input to the flip-flop for state D (y[3])
        // Transitions to state D (000100 or y[3])
        if ((y == 6'b000010 && w == 0) || // B->D
            (y == 6'b000100 && w == 0) || // C->D
            (y == 6'b001000 && w == 0) || // D->A (but also assigns D for continuity)
            (y == 6'b010000 && w == 0) || // E->D
            (y == 6'b100000 && w == 1)) begin // F->D
            Y3 = 1;
        end
    end
endmodule
