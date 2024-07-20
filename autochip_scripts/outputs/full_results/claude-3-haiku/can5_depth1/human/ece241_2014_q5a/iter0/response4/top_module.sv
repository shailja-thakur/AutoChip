module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam STATE_RESET = 2'b00;
localparam STATE_CALC = 2'b01;
localparam STATE_COMPLETE = 2'b10;

reg [1:0] state, next_state;
reg [7:0] num, num_complement;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_RESET;
        num <= 0;
        num_complement <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        num <= (state == STATE_CALC) ? {num[6:0], x} : num;
        num_complement <= (state == STATE_CALC) ? num_complement - {7'b0, x} : num_complement;
        z <= (state == STATE_COMPLETE) ? ~num_complement[7] : 0;
    end
end

always @(*) begin
    case (state)
        STATE_RESET: next_state = (areset) ? STATE_RESET : STATE_CALC;
        STATE_CALC: next_state = (areset) ? STATE_RESET : STATE_COMPLETE;
        STATE_COMPLETE: next_state = (areset) ? STATE_RESET : STATE_COMPLETE;
        default: next_state = STATE_RESET;
    endcase
end

endmodule
