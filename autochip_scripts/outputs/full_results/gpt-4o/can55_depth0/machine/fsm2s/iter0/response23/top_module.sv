module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define the states
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition based on current state and inputs
    always @(*) begin
        case (state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A;  // Default to state A
        endcase
    end

    // State and output update on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;  // Initialize to state A
            out <= 0;    // Output is low in state A
        end else begin
            state <= next_state;
            out <= (next_state == B);  // Output is high in state B
        end
    end

endmodule
