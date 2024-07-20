module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 0, COMPUTE = 1;
reg state, next_state;
reg [7:0] num, neg_num;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        num <= 0;
        neg_num <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        num <= {num[6:0], x};
        neg_num <= neg_num + {7'b0000000, x};
        z <= (state == COMPUTE) ? ~neg_num[7] : 0;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (~areset) begin
                next_state = COMPUTE;
            end
            else begin
                next_state = IDLE;
            end
        end
        COMPUTE: begin
            if (areset) begin
                next_state = IDLE;
            end
            else begin
                next_state = COMPUTE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
