module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    // State encoding
    typedef enum logic [1:0] {
        S_A = 2'b00,
        S_B = 2'b01
    } state_t;

    // State and next_state variables
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S_A: next_state = (in) ? S_A : S_B;
            S_B: next_state = (in) ? S_B : S_A;
            default: next_state = S_B; // Default case to handle invalid states
        endcase
    end

    // State register (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_B;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == S_B);

endmodule
