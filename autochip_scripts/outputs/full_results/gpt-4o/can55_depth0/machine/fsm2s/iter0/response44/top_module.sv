module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // Define state encoding
    typedef enum reg {A, B} state_t;
    state_t current_state, next_state;
    
    // State transition logic
    always @(*) begin
        case (current_state)
            A: begin
                if (j)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (k)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = A; // Default state
        endcase
    end
    
    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end
    
    // Output logic
    always @(posedge clk) begin
        if (current_state == B)
            out <= 1;
        else
            out <= 0;
    end

endmodule
