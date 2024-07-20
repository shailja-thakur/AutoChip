module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State Declaration
    typedef enum reg {STATE_START, STATE_ONE, STATE_TWO} state_t;
    state_t state, next_state;

    // Sequential Logic: State Transitions
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_START;
        else
            state <= next_state;
    end

    // Combinational Logic: Next State Logic and Output Logic
    always @(*) begin
        case (state)
            STATE_START: begin
                if (x == 1) begin
                    next_state = STATE_ONE;
                    z = 1;  // Start the 2's complement by flipping the bit
                end else begin
                    next_state = STATE_START;
                    z = 0;  // Pass the bit through as is
                end
            end
            STATE_ONE: begin
                next_state = STATE_TWO;
                z = ~x;  // Invert the incoming bits
            end
            STATE_TWO: begin
                next_state = STATE_TWO;
                z = ~x;  // Continue inverting the incoming bits
            end
            default: begin
                next_state = STATE_START;
                z = 0;
            end
        endcase
    end

endmodule
