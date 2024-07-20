module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State declaration
    typedef enum reg {
        A = 0,
        B = 1
    } state_t;

    state_t state, next_state;

    // Output logic
    assign out = (state == B);

    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = A;  // Default state to avoid latches
        endcase
    end

    // Sequential logic to update state
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset state
        else
            state <= next_state;
    end
    
endmodule
