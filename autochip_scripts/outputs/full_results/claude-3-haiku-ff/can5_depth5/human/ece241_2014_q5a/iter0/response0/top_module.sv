module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 0, COMPUTE = 1;
reg state, next_state;
reg [7:0] num, neg_num;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        num <= 0;
        neg_num <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        num <= (state == IDLE) ? {num[6:0], x} : num;
        neg_num <= (state == COMPUTE) ? ~num + 1 : neg_num;
        z <= (state == COMPUTE) ? neg_num[0] : 0;
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = (areset == 0) ? COMPUTE : IDLE;
        COMPUTE: next_state = (num == 0) ? IDLE : COMPUTE;
        default: next_state = IDLE;
    endcase
end

endmodule
