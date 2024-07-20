module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Combinational logic block to determine the next state
    always @(*) begin
        case(state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B; // default to state B
        endcase
    end

    // Sequential block triggered on the rising edge of clk
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset state to B
        else
            state <= next_state; // Update state
    end

    // Assign out output based on the state register
    always @(state) begin
        out = (state == B);
    end

endmodule
