module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t state, next_state;

    // Combinational logic for next state
    always @(*) begin
        case (state)
            STATE_A:    next_state = in ? STATE_B : STATE_A;
            STATE_B:    next_state = in ? STATE_B : STATE_C;
            STATE_C:    next_state = in ? STATE_D : STATE_A;
            STATE_D:    next_state = in ? STATE_B : STATE_C;
            default:    next_state = STATE_A; // Default state
        endcase
    end

    // Sequential logic for state update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == STATE_D);

endmodule
