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
                    next_state = 2'b01; // Next state B
                else
                    next_state = 2'b00; // Next state A
                out = 1'b0; // Output for state A
            end
            2'b01: begin // State B
                if (in)
                    next_state = 2'b01; // Next state B
                else
                    next_state = 2'b10; // Next state C
                out = 1'b0; // Output for state B
            end
            2'b10: begin // State C
                if (in)
                    next_state = 2'b11; // Next state D
                else
                    next_state = 2'b00; // Next state A
                out = 1'b0; // Output for state C
            end
            2'b11: begin // State D
                if (in)
                    next_state = 2'b01; // Next state B
                else
                    next_state = 2'b10; // Next state C
                out = 1'b1; // Output for state D
            end
            default: begin
                next_state = 2'b00; // Default next state
                out = 1'b0;  // Default output
            end
        endcase
    end

endmodule
