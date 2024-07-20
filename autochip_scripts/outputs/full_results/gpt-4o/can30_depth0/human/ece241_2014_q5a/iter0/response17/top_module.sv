module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S_ZERO = 2'b00,    // Initial state, expecting zero state from the 2's complement operation.
        S_ONE  = 2'b01,    // State after the first one is encountered, flipping bits.
        S_DONE = 2'b10     // Completed state, should remain in this state until reset.
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= S_ZERO;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        case (state)
            S_ZERO: begin
                if (x == 1'b1) begin
                    next_state = S_ONE;
                    z = 1'b1; // Flip first 1 encountered
                end else begin
                    next_state = S_ZERO;
                    z = 1'b0;
                end
            end
            S_ONE: begin
                next_state = S_ONE; // Remain in the S_ONE state for further inputs
                z = ~x; // Flip all subsequent bits
            end
            default: begin
                next_state = S_ZERO;
                z = 1'b0;
            end
        endcase
    end

endmodule
