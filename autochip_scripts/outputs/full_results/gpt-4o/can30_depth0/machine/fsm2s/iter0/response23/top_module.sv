module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [0:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;

    // Current and next state variables
    state_t current_state, next_state;

    // Next state logic based on current state and inputs
    always @(*) begin
        case (current_state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
        endcase
    end

    // State transition on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(current_state) begin
        case (current_state)
            A: out = 1'b0;
            B: out = 1'b1;
        endcase
    end

endmodule
