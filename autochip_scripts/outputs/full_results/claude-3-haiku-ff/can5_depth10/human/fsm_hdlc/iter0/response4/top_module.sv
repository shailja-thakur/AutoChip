module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state, next_state;
localparam IDLE = 3'b000, DISC = 3'b001, FLAG = 3'b010, ERR = 3'b011;

// State transition logic
always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    next_state = state;
    case (state)
        IDLE: next_state = (in) ? DISC : IDLE;
        DISC: next_state = (in) ? ((state == DISC) ? ERR : FLAG) : IDLE;
        FLAG: next_state = (in) ? ERR : IDLE;
        ERR: next_state = (in) ? ERR : IDLE;
    endcase
end

// Output logic
always @(*) begin
    disc = 0;
    flag = 0;
    err = 0;
    case (state)
        DISC: disc = 1;
        FLAG: flag = 1;
        ERR: err = 1;
    endcase
end

endmodule
