module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State declaration
    typedef enum reg [1:0] {STATE_A, STATE_B} state_t;
    state_t state, next_state;

    // State transition
    always @(*) begin
        case(state)
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
        endcase
    end

    // State register and output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B; // asynchronously reset to state B
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case(state)
            STATE_A: out = 0;
            STATE_B: out = 1;
        endcase
    end

endmodule
