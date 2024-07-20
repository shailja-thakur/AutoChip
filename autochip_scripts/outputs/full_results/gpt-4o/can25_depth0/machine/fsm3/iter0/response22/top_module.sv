module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define state encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    // Current state and next state registers
    reg [1:0] state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            STATE_A: next_state = in ? STATE_B : STATE_A;
            STATE_B: next_state = in ? STATE_B : STATE_C;
            STATE_C: next_state = in ? STATE_D : STATE_A;
            STATE_D: next_state = in ? STATE_B : STATE_C;
            default: next_state = STATE_A;
        endcase
    end

    // State register update (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        out = (state == STATE_D);
    end

endmodule
