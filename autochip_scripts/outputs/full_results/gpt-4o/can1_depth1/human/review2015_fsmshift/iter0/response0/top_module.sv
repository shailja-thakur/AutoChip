module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] state;
    reg [2:0] next_state;

    localparam STATE_IDLE = 3'd0,
               STATE_SHIFT1 = 3'd1,
               STATE_SHIFT2 = 3'd2,
               STATE_SHIFT3 = 3'd3,
               STATE_SHIFT4 = 3'd4;

    // State transition logic (Moore FSM)
    always @(*) begin
        case (state)
            STATE_IDLE : next_state = (reset) ? STATE_SHIFT1 : STATE_IDLE;
            STATE_SHIFT1: next_state = STATE_SHIFT2;
            STATE_SHIFT2: next_state = STATE_SHIFT3;
            STATE_SHIFT3: next_state = STATE_SHIFT4;
            STATE_SHIFT4: next_state = STATE_IDLE;
            default: next_state = STATE_IDLE;
        endcase
    end

    // State flip-flops
    always @(posedge clk) begin
        if (reset)
            state <= STATE_SHIFT1;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            shift_ena <= 1'b1;
        else if (state == STATE_SHIFT4)
            shift_ena <= 1'b0;
        else
            shift_ena <= (state != STATE_IDLE);
    end

endmodule
