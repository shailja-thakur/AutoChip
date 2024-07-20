module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    always @(*) begin
        // Default values
        next_state = 4'b0000;
        out = 1'b0;
        
        case (state)
            4'b0001: begin // State A
                if (in == 1'b0)
                    next_state = 4'b0001; // Stay in state A
                else
                    next_state = 4'b0010; // Move to state B

                out = 1'b0; // Output for state A
            end
            
            4'b0010: begin // State B
                if (in == 1'b0)
                    next_state = 4'b0100; // Move to state C
                else
                    next_state = 4'b0010; // Stay in state B

                out = 1'b0; // Output for state B
            end
            
            4'b0100: begin // State C
                if (in == 1'b0)
                    next_state = 4'b0001; // Move to state A
                else
                    next_state = 4'b1000; // Move to state D

                out = 1'b0; // Output for state C
            end
            
            4'b1000: begin // State D
                if (in == 1'b0)
                    next_state = 4'b0100; // Move to state C
                else
                    next_state = 4'b0010; // Move to state B

                out = 1'b1; // Output for state D
            end
            
            default: begin
                next_state = 4'b0001; // Default state: State A
                out = 1'b0; // Default output
            end
        endcase
    end

endmodule
