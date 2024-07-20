module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

parameter STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10;
reg [1:0] state, next_state;
reg [1:0] w_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_A;
        w_count <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        w_count <= (state == STATE_B) ? w_count + (w ? 1 : 0) : 0;
        z <= (state == STATE_C && w_count == 2) ? 1 : 0;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_A: begin
            next_state = (s == 1) ? STATE_B : STATE_A;
        end
        STATE_B: begin
            next_state = (w_count == 3) ? STATE_C : STATE_B;
        end
        STATE_C: begin
            next_state = STATE_A;
        end
    endcase
end

endmodule
