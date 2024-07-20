module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // State encoding
    typedef enum reg {A = 1'b0, B = 1'b1} state_t;
    state_t state, next_state;

    // Asynchronous reset logic
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;  // Reset to state B
        end else begin
            state <= next_state;  // Transition to the next state on clock edge
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            B: next_state = (in) ? B : A;
            A: next_state = (in) ? A : B;
            default: next_state = B;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            B: out = 1'b1;
            A: out = 1'b0;
            default: out = 1'b1;
        endcase
    end

endmodule
