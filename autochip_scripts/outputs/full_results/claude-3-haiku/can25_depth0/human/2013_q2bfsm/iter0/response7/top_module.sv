module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

reg [1:0] state, next_state;
reg [1:0] x_count;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A;
        x_count <= 0;
        f <= 0;
        g <= 0;
    end
    else begin
        state <= next_state;
        x_count <= (state == STATE_B) ? x_count + 1 : 0;
        f <= (state == STATE_B) ? 1 : 0;
        g <= (state == STATE_D) ? 1 : (state == STATE_C && y) ? 1 : 0;
    end
end

always @(*) begin
    case (state)
        STATE_A: next_state = resetn ? STATE_B : STATE_A;
        STATE_B: next_state = (x_count == 2'b10) ? STATE_C : STATE_B;
        STATE_C: next_state = (y) ? STATE_D : STATE_C;
        STATE_D: next_state = STATE_D;
        default: next_state = STATE_A;
    endcase
end

endmodule
