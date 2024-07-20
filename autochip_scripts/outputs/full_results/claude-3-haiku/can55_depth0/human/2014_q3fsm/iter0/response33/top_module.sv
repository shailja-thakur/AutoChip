module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10;
reg [1:0] state, next_state;
reg [1:0] count_w;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_A;
        count_w <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        count_w <= (state == STATE_B && w) ? count_w + 1 : 0;
        z <= (state == STATE_C && count_w == 2) ? 1 : 0;
    end
end

always @(*) begin
    case (state)
        STATE_A: next_state = (s) ? STATE_B : STATE_A;
        STATE_B: next_state = STATE_C;
        STATE_C: next_state = STATE_B;
        default: next_state = STATE_A;
    endcase
end

endmodule
