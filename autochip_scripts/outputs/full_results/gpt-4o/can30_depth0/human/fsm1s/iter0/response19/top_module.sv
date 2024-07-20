module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg {A, B} state_t;
    state_t current_state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= B;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            B: next_state = (in) ? B : A;
            A: next_state = (in) ? A : B;
            default: next_state = B; // default case to handle unexpected state
        endcase
    end

    // Output logic (Moore machine)
    always @(*) begin
        case (current_state)
            B: out = 1;
            A: out = 0;
            default: out = 1; // default output for unexpected states
        endcase
    end

endmodule
