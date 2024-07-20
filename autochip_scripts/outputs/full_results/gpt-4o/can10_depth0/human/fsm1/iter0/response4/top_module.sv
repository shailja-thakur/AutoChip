module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Asynchronous reset logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // State transition logic
    always @(*) begin
        case(state)
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
            default: next_state = B; // Default case, should not be hit
        endcase
    end

    // Output logic
    always @(*) begin
        case(state)
            B: out = 1;
            A: out = 0;
            default: out = 1;
        endcase
    end
endmodule
