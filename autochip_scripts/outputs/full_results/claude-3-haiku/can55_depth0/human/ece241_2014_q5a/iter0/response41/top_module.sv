module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 0, COMPUTE = 1;
reg state, next_state;
reg [7:0] sum;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        IDLE: begin
            if (~areset)
                next_state = COMPUTE;
            else
                next_state = IDLE;
            sum = 0;
            z = 0;
        end
        COMPUTE: begin
            if (areset)
                next_state = IDLE;
            else begin
                sum = {sum[6:0], x};
                z = ~sum[7] ? sum[7:0] : ~sum + 1;
                next_state = COMPUTE;
            end
        end
        default: begin
            next_state = IDLE;
            sum = 0;
            z = 0;
        end
    endcase
end

endmodule
