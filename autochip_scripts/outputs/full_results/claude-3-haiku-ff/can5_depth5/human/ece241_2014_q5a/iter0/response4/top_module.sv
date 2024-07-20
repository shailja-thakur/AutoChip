module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] 
    IDLE = 2'b00,
    CONVERT = 2'b01,
    DONE = 2'b11;

reg [1:0] state, next_state;
reg [7:0] num, negated;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        num <= 8'b0;
        negated <= 8'b0;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        num <= {num[6:0], x};
        if (state == CONVERT) begin
            negated <= ~num + 1'b1;
        end
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (~areset) begin
                next_state = CONVERT;
            end
            else begin
                next_state = IDLE;
            end
            z = 1'b0;
        end
        CONVERT: begin
            next_state = (num[7]) ? DONE : CONVERT;
            z = negated[0];
        end
        DONE: begin
            next_state = IDLE;
            z = negated[0];
        end
        default: begin
            next_state = IDLE;
            z = 1'b0;
        end
    endcase
end

endmodule
