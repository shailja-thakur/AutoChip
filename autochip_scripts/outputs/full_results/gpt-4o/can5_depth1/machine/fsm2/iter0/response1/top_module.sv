module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    typedef enum reg [1:0] {STATE_A = 2'b00, STATE_B = 2'b01} state_t;
    state_t state, next_state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            STATE_A: next_state = j ? STATE_B : STATE_A;
            STATE_B: next_state = k ? STATE_A : STATE_B;
            default: next_state = STATE_A;
        endcase
    end

    // Sequential logic to update the state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        out = (state == STATE_B);
    end

endmodule
