module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    always @(*) begin
        case(state)
            // State A
            4'b0001: begin
                if (in)
                    next_state = 4'b0010; // Transition to state B
                else
                    next_state = 4'b0100; // Transition to state C
                out = 1'b0; // Output for state A
            end
            
            // State B
            4'b0010: begin
                if (in)
                    next_state = 4'b0001; // Transition to state A
                else
                    next_state = 4'b0100; // Transition to state C
                out = 1'b0; // Output for state B
            end
            
            // State C
            4'b0100: begin
                if (in)
                    next_state = 4'b0001; // Transition to state A
                else
                    next_state = 4'b1000; // Transition to state D
                out = 1'b0; // Output for state C
            end
            
            // State D
            4'b1000: begin
                if (in)
                    next_state = 4'b0010; // Transition to state B
                else
                    next_state = 4'b0010; // Transition to state B
                out = 1'b1; // Output for state D
            end
            
            default: begin
                next_state = 4'b0000; // Default next state
                out = 1'b0; // Default output
            end
        endcase
    end
endmodule
