module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam STATE_A = 2'd0, STATE_B = 2'd1, STATE_C = 2'd2;
reg [1:0] state, next_state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset)
        state <= STATE_A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        STATE_A: begin
            if (s)
                next_state = STATE_B;
            else
                next_state = STATE_A;
            z = 0;
        end
        STATE_B: begin
            if (count == 2'd2 && w)
                next_state = STATE_C;
            else
                next_state = STATE_B;
            z = 0;
        end
        STATE_C: begin
            z = 1;
            next_state = STATE_B;
            count = 0;
        end
        default: begin
            next_state = STATE_A;
            z = 0;
        end
    endcase
end

always @(posedge clk) begin
    if (state == STATE_B)
        count <= count + 1;
    else
        count <= 0;
end

endmodule
