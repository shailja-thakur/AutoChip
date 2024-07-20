module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Declare state types
    typedef enum reg {A, B} state_type;
    state_type state, next_state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            A: if (x) next_state = B; else next_state = A;
            B: next_state = B;
            default: next_state = A; // Default case to handle unexpected states
        endcase
    end

    // Sequential logic to move to the next state on the clock edge or reset asynchronously
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset to state A
        else
            state <= next_state; // Transition to next state
    end

    // Output logic based on the current state and input x
    always @(*) begin
        case (state)
            A: z = x;
            B: z = ~x;
            default: z = 0;
        endcase
    end

endmodule
