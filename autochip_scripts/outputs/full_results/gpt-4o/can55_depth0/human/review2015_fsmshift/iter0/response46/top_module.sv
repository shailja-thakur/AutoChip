module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [2:0] state, next_state; // 3-bit state to keep track of the shift enable cycles

// State encoding
localparam IDLE = 3'b000,
           S1   = 3'b001,
           S2   = 3'b010,
           S3   = 3'b011,
           S4   = 3'b100;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        IDLE: next_state = reset ? S1 : IDLE;
        S1:   next_state = S2;
        S2:   next_state = S3;
        S3:   next_state = S4;
        S4:   next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

// Output logic: shift_ena
always @(*) begin
    case (state)
        S1: shift_ena = 1;
        S2: shift_ena = 1;
        S3: shift_ena = 1;
        S4: shift_ena = 1;
        default: shift_ena = 0;
    endcase
end

endmodule
