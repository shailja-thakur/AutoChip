module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    // Current state and next state variables
    state_t curr_state, next_state;

    // State transition logic
    always @(*) begin
        // Default next state
        next_state = curr_state;
        case (curr_state)
            A: if (in) next_state = B; else next_state = A;
            B: if (in) next_state = B; else next_state = C;
            C: if (in) next_state = D; else next_state = A;
            D: if (in) next_state = B; else next_state = C;
            default: next_state = A; // Fallback in case of invalid state
        endcase
    end

    // Synchronous state update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            curr_state <= A; // Reset to initial state
        end else begin
            curr_state <= next_state; // Update to next state
        end
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 1'b0;
        end else begin
            out <= (curr_state == D);
        end
    end

endmodule
