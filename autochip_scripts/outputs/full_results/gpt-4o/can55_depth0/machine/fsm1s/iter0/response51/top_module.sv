module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State Definitions
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State Register
    reg state;
    reg next_state;

    // Combinational Logic
    always @(*) begin
        case (state)
            A: if (in) next_state = A;
               else next_state = B;
            B: if (in) next_state = B;
               else next_state = A;
            default: next_state = A;  // Default state should be defined in case of undefined state
        endcase
    end

    // State Update Logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;  // Default state on reset
        else
            state <= next_state;  // Update state based on combinational logic
    end

    // Output Logic
    assign out = (state == B);

endmodule
