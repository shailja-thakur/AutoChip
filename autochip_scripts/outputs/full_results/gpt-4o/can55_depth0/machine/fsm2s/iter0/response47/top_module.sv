module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A; // Initialize to state A on reset
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
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
            default: next_state = A; // Default to state A for safety
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A: out = 0;
            B: out = 1;
            default: out = 0; // Default to 0 for safety
        endcase
    end

endmodule
