module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [0:0] {STATE_A = 1'b0, STATE_B = 1'b1} state_t;
    state_t state, next_state;

    // Combinational block to determine the next state
    always @(*) begin
        case (state)
            STATE_A: begin
                if (j)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (k)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
        endcase
    end

    // Clocked block to update the current state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (state == STATE_B)
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
