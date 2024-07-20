module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    // Logic for Y2 and Y4 next-state signals
    always @(*) begin
        // Initialize outputs to 0
        Y2 = 1'b0;
        Y4 = 1'b0;

        // Derive Y2 and Y4 based on the current state and input w
        case (y)
            6'b000001: begin // State A
                if (w == 1'b0) Y2 = 1'b1; // Move to state B
                // No transition for w == 1'b1 since it remains in state A
            end
            6'b000010: begin // State B
                if (w == 1'b0) Y4 = 1'b1; // Move to state C
                // No transition for w == 1'b1 since it would go to state D
            end
            6'b000100: begin // State C
                // No transition for w == 1'b0 since it would go to state E
                if (w == 1'b1) Y4 = 1'b1; // Move to state D
            end
            6'b001000: begin // State D
                // No transition for w == 1'b0 since it would go to state F
                if (w == 1'b1) Y2 = 1'b1; // Move to state A
            end
            6'b010000: begin // State E
                if (w == 1'b1) Y4 = 1'b1; // Move to state D
                // No transition for w == 1'b0 since it remains in state E
            end
            6'b100000: begin // State F
                // No transition for w == 1'b0 since it would go to state C
                if (w == 1'b1) Y4 = 1'b1; // Move to state D
            end
            default: begin
                Y2 = 1'b0;
                Y4 = 1'b0;
            end
        endcase
    end
endmodule
