module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State declaration
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition logic (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= B; // Reset state is B
        end else begin
            state <= next_state;
        end
    end

    // Next state logic (combinational)
    always @(*) begin
        case (state)
            B: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
                out = 1;
            end
            A: begin
                if (in) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
                out = 0;
            end
            default: begin
                next_state = B; // Default to reset state
                out = 1;
            end
        endcase
    end
endmodule
