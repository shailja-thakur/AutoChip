module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State declaration
    typedef enum logic {A, B} state_t;
    state_t state, next_state;

    // Combinational logic to determine the next state
    always_comb begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end

    // Sequential logic to update the current state
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always_comb begin
        out = (state == B);
    end

endmodule
