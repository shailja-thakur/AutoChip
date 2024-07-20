module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter INIT = 0, CONVERT = 1;
reg state, next_state;
reg [7:0] num, next_num;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= INIT;
        num <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        num <= next_num;
        z <= num[0];
    end
end

always @(*) begin
    next_state = state;
    next_num = num;
    case (state)
        INIT: begin
            if (!areset) begin
                next_state = CONVERT;
                next_num = 0;
            end
        end
        CONVERT: begin
            next_num = {num[6:0], x};
            if (areset) begin
                next_state = INIT;
                next_num = 0;
            end
            else begin
                z = ~num[0];
            end
        end
    endcase
end

endmodule
