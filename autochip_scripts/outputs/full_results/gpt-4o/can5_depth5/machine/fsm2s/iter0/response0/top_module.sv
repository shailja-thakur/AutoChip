module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define states
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;   // Initialize state to A on reset
        end else begin
            state <= next_state;  // Update state
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
            A: begin
                if (j) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (k) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            default: next_state = A;  // Default to state A
        endcase
    end

    // Output Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 1'b0;  // Output low on reset
        end else begin
            out <= (state == B) ? 1'b1 : 1'b0;  // Output high when in state B
        end
    end

endmodule
