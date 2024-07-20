module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state, next_state;
    reg [2:0] counter;

    // States
    localparam IDLE   = 3'b000;
    localparam SHIFT1 = 3'b001;
    localparam SHIFT2 = 3'b010;
    localparam SHIFT3 = 3'b011;
    localparam SHIFT4 = 3'b100;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE:   next_state = (reset) ? SHIFT1 : IDLE;
            SHIFT1: next_state = SHIFT2;
            SHIFT2: next_state = SHIFT3;
            SHIFT3: next_state = SHIFT4;
            SHIFT4: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // State flip-flops
    always @(posedge clk) begin
        if (reset)
            state <= SHIFT1;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        shift_ena = (state == SHIFT1 || state == SHIFT2 ||
                     state == SHIFT3 || state == SHIFT4) ? 1'b1 : 1'b0;
    end

endmodule
