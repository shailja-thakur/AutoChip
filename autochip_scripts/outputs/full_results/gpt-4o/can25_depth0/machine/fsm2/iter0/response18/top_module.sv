module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define the states
    typedef enum logic {
        A = 1'b0,
        B = 1'b1
    } state_t;

    // Declare state variables
    state_t state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A; // Just in case
        endcase
    end

    // Sequential logic to update state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
