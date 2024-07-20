module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    always @(*) begin
        case (state)
            2'b00: begin // State A
                if (in)
                    next_state = 2'b01; // Go to state B
                else
                    next_state = 2'b00; // Stay in state A
                out = 0;
            end
            2'b01: begin // State B
                if (in)
                    next_state = 2'b01; // Stay in state B
                else
                    next_state = 2'b10; // Go to state C
                out = 0;
            end
            2'b10: begin // State C
                if (in)
                    next_state = 2'b11; // Go to state D
                else
                    next_state = 2'b00; // Go to state A
                out = 0;
            end
            2'b11: begin // State D
                if (in)
                    next_state = 2'b01; // Go to state B
                else
                    next_state = 2'b10; // Go to state C
                out = 1;
            end
            default: begin
                next_state = 2'b00; // Default to state A (safety)
                out = 0;
            end
        endcase
    end

endmodule
