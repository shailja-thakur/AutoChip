module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S0, // Initial state
        S1, // State after detecting '1'
        S2  // State after detecting '10'
    } state_t;

    state_t state, next_state;

    // State transition logic (Mealy FSM)
    always @(*) begin
        case (state)
            S0: begin
                if (x) begin
                    next_state = S1; // '1' detected
                    z = 0; // No sequence detected yet
                end
                else begin
                    next_state = S0;
                    z = 0; // No sequence detected
                end
            end
            
            S1: begin
                if (x) begin
                    next_state = S1; // Still '1', stay in S1
                    z = 0; // No sequence detected yet
                end
                else begin
                    next_state = S2; // '10' detected
                    z = 0; // No sequence detected yet
                end
            end

            S2: begin
                if (x) begin
                    next_state = S1; // '101' detected
                    z = 1; // Sequence detected
                end
                else begin
                    next_state = S0; // Only '10', go to initial state
                    z = 0; // No sequence detected
                end
            end

            default: begin
                next_state = S0;
                z = 0; // Default state when uncertain
            end
        endcase
    end

    // State register with asynchronous reset
    always @(negedge aresetn or posedge clk) begin
        if (!aresetn) begin
            state <= S0; // Reset to initial state
        end
        else begin
            state <= next_state; // Update state
        end
    end

endmodule
