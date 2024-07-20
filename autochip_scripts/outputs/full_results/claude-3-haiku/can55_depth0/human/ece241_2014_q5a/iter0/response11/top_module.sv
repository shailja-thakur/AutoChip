module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter WAITING = 2'b00, COMPUTING = 2'b01, COMPLETE = 2'b11;
reg [1:0] state, next_state;
reg [7:0] num, neg_num;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WAITING;
        num <= 8'b0;
        neg_num <= 8'b0;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        num <= {num[6:0], x};
        neg_num <= ~num + 1'b1;
        z <= (state == COMPLETE) ? neg_num[0] : 1'b0;
    end
end

always @(*) begin
    case (state)
        WAITING: begin
            if (x) begin
                next_state = COMPUTING;
            end
            else begin
                next_state = WAITING;
            end
        end
        COMPUTING: begin
            if (num[7]) begin
                next_state = COMPLETE;
            end
            else begin
                next_state = COMPUTING;
            end
        end
        COMPLETE: begin
            next_state = WAITING;
        end
        default: begin
            next_state = WAITING;
        end
    endcase
end

endmodule
