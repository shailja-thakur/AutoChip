module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 2'b00, COMPUTE = 2'b01;
reg [1:0] state, next_state;
reg [7:0] accumulator;

always @(posedge clk, negedge areset) begin
    if (~areset) begin
        state <= IDLE;
        accumulator <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        if (state == COMPUTE) begin
            accumulator <= {accumulator[6:0], x};
        end
        if (state == COMPUTE && accumulator == 8'b11111111) begin
            z <= 1;
        end
        else begin
            z <= 0;
        end
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            next_state = (x == 1) ? COMPUTE : IDLE;
        end
        COMPUTE: begin
            next_state = (accumulator == 8'b11111111) ? IDLE : COMPUTE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
