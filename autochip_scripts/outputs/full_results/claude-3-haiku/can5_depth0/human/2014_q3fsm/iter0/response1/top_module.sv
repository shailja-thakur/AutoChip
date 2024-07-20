module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;

reg [1:0] state, next_state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_A;
        count <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        count <= (state == STATE_B) ? count + 1 : 0;
        z <= (state == STATE_C && count == 2) ? 1 : 0;
    end
end

always @(*) begin
    case (state)
        STATE_A: begin
            next_state = (s == 1) ? STATE_B : STATE_A;
        end
        STATE_B: begin
            next_state = (count == 3) ? STATE_C : STATE_B;
        end
        STATE_C: begin
            next_state = STATE_A;
        end
        default: begin
            next_state = STATE_A;
        end
    endcase
end

endmodule
