module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition
    always @(*) begin
        case (state)
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
            default: next_state = B; // Default to state B
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: out = 0;
            B: out = 1;
            default: out = 1; // Default to state B's output
        endcase
    end

endmodule
