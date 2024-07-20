module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 0, CONVERT = 1;
reg state, next_state;
reg[7:0] temp;
reg[3:0] count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        temp <= 0;
        count <= 0;
    end
    else begin
        state <= next_state;
        if (state == CONVERT) begin
            temp <= {temp[6:0], x};
            count <= count + 1;
        end
    end
end

always @(*) begin
    next_state = state;
    z = 0;
    case (state)
        IDLE: begin
            if (~areset) begin
                next_state = CONVERT;
            end
        end
        CONVERT: begin
            if (count == 8) begin
                next_state = IDLE;
                z = ~temp + 1;
            end
        end
    endcase
end

endmodule
