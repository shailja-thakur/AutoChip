module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [1:0] IDLE = 2'b00,
                 DETECT_FIVE = 2'b01,
                 DETECT_SIX = 2'b10,
                 DETECT_SEVEN = 2'b11;

reg [1:0] state, next_state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        state <= next_state;
        count <= (in) ? count + 1 : 0;
        disc <= (state == DETECT_FIVE && in) ? 1 : 0;
        flag <= (state == DETECT_SIX && in) ? 1 : 0;
        err <= (state == DETECT_SEVEN && in) ? 1 : 0;
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = (in) ? DETECT_FIVE : IDLE;
        DETECT_FIVE: next_state = (in) ? DETECT_SIX : IDLE;
        DETECT_SIX: next_state = (in) ? DETECT_SEVEN : IDLE;
        DETECT_SEVEN: next_state = (in) ? DETECT_SEVEN : IDLE;
        default: next_state = IDLE;
    endcase
end

endmodule
