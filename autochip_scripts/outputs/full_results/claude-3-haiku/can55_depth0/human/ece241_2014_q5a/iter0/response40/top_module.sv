module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 2'b00, CONVERT = 2'b01, DONE = 2'b10;
reg [1:0] state, next_state;
reg [7:0] num, neg_num;
reg [3:0] count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        num <= 0;
        neg_num <= 0;
        count <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        num <= (state == CONVERT) ? {num[6:0], x} : num;
        neg_num <= (state == CONVERT) ? ~num + 1 : neg_num;
        count <= (state == CONVERT) ? count + 1 : count;
        z <= (state == DONE) ? neg_num[0] : 0;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            next_state = (areset) ? IDLE : CONVERT;
        end
        CONVERT: begin
            next_state = (count == 8) ? DONE : CONVERT;
        end
        DONE: begin
            next_state = (areset) ? IDLE : DONE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
