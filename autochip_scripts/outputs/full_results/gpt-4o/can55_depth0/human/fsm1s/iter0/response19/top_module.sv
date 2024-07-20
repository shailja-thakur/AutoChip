module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum reg {A, B} state_t;
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            B: begin
                if (in == 0) 
                    next_state = A;
                else 
                    next_state = B;
            end
            A: begin
                if (in == 0)
                    next_state = B;
                else
                    next_state = A;
            end
            default: 
                next_state = B;  // Default state
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset)
            current_state <= B;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            B: out = 1;
            A: out = 0;
            default: out = 1;  // Default output when in undefined state
        endcase
    end

endmodule
