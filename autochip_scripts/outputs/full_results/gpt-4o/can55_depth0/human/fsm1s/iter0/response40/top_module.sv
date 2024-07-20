module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            B: if (in == 1'b0)
                    next_state = A;
               else
                    next_state = B;
            A: if (in == 1'b0)
                    next_state = B;
               else
                    next_state = A;
            default: next_state = B; // Default to reset state
        endcase
    end
    
    // State register
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        case (state)
            B: out = 1'b1;
            A: out = 1'b0;
            default: out = 1'b1;
        endcase
    end

endmodule
