module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    typedef enum reg [0:0] {STATE_A, STATE_B} state_t;
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: next_state = (in) ? STATE_A : STATE_B;
            STATE_B: next_state = (in) ? STATE_B : STATE_A;
            default: next_state = STATE_B; // default to state B
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign out = (state == STATE_B);

endmodule
