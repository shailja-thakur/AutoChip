module top_module (
	input [5:0] y,
	input w,
	output reg Y1,
	output reg Y3
);

    always @(*) begin
        // Y1 is the input for the state flip-flop y[1], corresponding to state B
        // Transitions to state B are from state A on input w
        if (y == 6'b000001 && w) begin  // If in state A and w is 1, transition to state B
            Y1 = 1;
        end else begin
            Y1 = 0;
        end

        // Y3 is the input for the state flip-flop y[3], corresponding to state D
        // Transitions to state D are from state B on input w=0, from state C on input w=0, from state F on input w=0, and from state D on input w=0
        if ((y == 6'b000010 && !w) ||  // If in state B and w is 0, transition to state D
            (y == 6'b000100 && !w) ||  // If in state C and w is 0, transition to state D
            (y == 6'b100000 && !w) ||  // If in state F and w is 0, transition to state D
            (y == 6'b001000 && !w)) begin  // If in state D and w is 0, transition to state D
            Y3 = 1;
        end else begin
            Y3 = 0;
        end
    end

endmodule
