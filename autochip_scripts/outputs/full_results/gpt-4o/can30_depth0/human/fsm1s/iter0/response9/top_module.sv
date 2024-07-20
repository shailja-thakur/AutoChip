module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg {A, B} state_t;
    
    state_t current_state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (current_state)
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            A: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = B; // Default state
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            current_state <= B; // Reset to state B
        else
            current_state <= next_state;
    end

    // Output logic (combinational)
    always @(*) begin
        case (current_state)
            B: out = 1;
            A: out = 0;
            default: out = 1; // Default output
        endcase
    end

endmodule
