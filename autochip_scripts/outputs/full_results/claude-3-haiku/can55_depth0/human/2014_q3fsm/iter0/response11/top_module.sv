module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10;
reg [1:0] state, next_state;
reg [1:0] w_count;

always @(posedge clk) begin
    if (reset)
        state <= STATE_A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        STATE_A:
            if (s)
                next_state = STATE_B;
            else
                next_state = STATE_A;
        STATE_B:
            if (w_count == 2'b10)
                next_state = STATE_C;
            else
                next_state = STATE_B;
        STATE_C:
            if (w_count == 2'b10)
                next_state = STATE_C;
            else
                next_state = STATE_B;
        default:
            next_state = STATE_A;
    endcase
end

always @(posedge clk) begin
    if (reset)
        w_count <= 0;
    else if (state == STATE_B || state == STATE_C)
        w_count <= {w_count[0], w};
end

always @(posedge clk) begin
    if (reset)
        z <= 0;
    else if (state == STATE_C && w_count == 2'b10)
        z <= 1;
    else
        z <= 0;
end

endmodule
