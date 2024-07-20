module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always_comb begin
        case (state)
            A: if (in) next_state = A;
               else next_state = B;
            B: if (in) next_state = B;
               else next_state = A;
            default: next_state = B; // default to state B
        endcase
    end

    // State update on clock rising edge or asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b1;
        else
            out <= (state == B);
    end

endmodule
