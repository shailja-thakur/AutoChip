module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] state, next_state;
    localparam IDLE = 3'b000, SHIFT1 = 3'b001, SHIFT2 = 3'b010, SHIFT3 = 3'b011, SHIFT4 = 3'b100, DONE = 3'b101;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            IDLE: next_state = reset ? SHIFT1 : IDLE;
            SHIFT1: next_state = SHIFT2;
            SHIFT2: next_state = SHIFT3;
            SHIFT3: next_state = SHIFT4;
            SHIFT4: next_state = DONE;
            DONE: next_state = DONE;
            default: next_state = IDLE;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) 
            state <= SHIFT1;
        else
            state <= next_state;
    end

    // Output logic (combinational)
    always @(*) begin
        case (state)
            SHIFT1: shift_ena = 1;
            SHIFT2: shift_ena = 1;
            SHIFT3: shift_ena = 1;
            SHIFT4: shift_ena = 1;
            DONE: shift_ena = 0;
            default: shift_ena = 0;
        endcase
    end

endmodule
