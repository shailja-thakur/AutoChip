module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam IDLE = 2'b00;
localparam COMPUTE = 2'b01;
localparam DONE = 2'b10;

reg [1:0] state, next_state;
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
        num <= (state == COMPUTE) ? {num[6:0], x} : num;
        neg_num <= (state == COMPUTE) ? ~num + 1 : neg_num;
        z <= (state == DONE) ? neg_num[0] : 0;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            next_state = (x) ? COMPUTE : IDLE;
        end
        COMPUTE: begin
            next_state = (x == 1'b0) ? DONE : COMPUTE;
        end
        DONE: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
