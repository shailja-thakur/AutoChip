module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Sequential logic for state transition and reset logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;             // Reset state to B
        else
            state <= next_state;    // Update state
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
        endcase
    end

    // Output logic
    always @(*) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end
endmodule
