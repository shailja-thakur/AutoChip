module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    // State transition logic using one-hot encoding
    always @(*) begin
        case (state)
            4'b0001: begin // A state
                if (in)
                    next_state = 4'b0010; // Transition to B
                else
                    next_state = 4'b0001; // Stay in A
                out = 0;
            end
            
            4'b0010: begin // B state
                if (in)
                    next_state = 4'b0010; // Stay in B
                else
                    next_state = 4'b0100; // Transition to C
                out = 0;
            end
            
            4'b0100: begin // C state
                if (in)
                    next_state = 4'b1000; // Transition to D
                else
                    next_state = 4'b0001; // Transition to A
                out = 0;
            end
            
            4'b1000: begin // D state
                if (in)
                    next_state = 4'b0010; // Transition to B
                else
                    next_state = 4'b0100; // Transition to C
                out = 1;
            end
            
            default: begin
                next_state = 4'b0001; // Default to A state
                out = 0;
            end
        endcase
    end
    
endmodule
