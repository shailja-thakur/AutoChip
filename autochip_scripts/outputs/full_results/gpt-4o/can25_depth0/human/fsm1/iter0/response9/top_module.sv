module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    typedef enum reg {A, B} state_t;
    state_t state, next_state;
    
    always @ (posedge clk or posedge areset) begin
        if (areset) 
            state <= B; // Asynchronous reset to state B
        else 
            state <= next_state;
    end

    always @ (*) begin
        case (state)
            A: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
                out = 0; // Output for state A
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
                out = 1; // Output for state B
            end
            default: begin
                next_state = B;
                out = 1; // Default output in case of an erroneous state
            end
        endcase
    end

endmodule
