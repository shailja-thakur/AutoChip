module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // After 1
        S2 = 2'b10  // After 10
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S0: if (x) next_state = S1; else next_state = S0;
            S1: if (x) next_state = S1; else next_state = S2;
            S2: if (x) next_state = S1; else next_state = S0;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        z = (state == S2) && x;
    end

    // State register with asynchronous reset
    always @(negedge aresetn or posedge clk) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

endmodule
