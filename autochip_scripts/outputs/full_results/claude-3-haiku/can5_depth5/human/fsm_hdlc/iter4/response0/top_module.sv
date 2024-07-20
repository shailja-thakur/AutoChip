module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state, next_state;
parameter IDLE = 3'b000, ONECOUNT = 3'b001, DISCARD = 3'b010, FLAG = 3'b011, ERROR = 3'b100;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = ONECOUNT;
            end
            else begin
                next_state = IDLE;
            end
        end
        ONECOUNT: begin
            if (in == 1'b1) begin
                next_state = ONECOUNT;
            end
            else if (in == 1'b0) begin
                next_state = IDLE;
            end
        end
        DISCARD: begin
            disc = 1'b1;
            if (in == 1'b1) begin
                next_state = ONECOUNT;
            end
            else if (in == 1'b0) begin
                next_state = IDLE;
            end
        end
        FLAG: begin
            flag = 1'b1;
            if (in == 1'b1) begin
                next_state = ONECOUNT;
            end
            else if (in == 1'b0) begin
                next_state = IDLE;
            end
        end
        ERROR: begin
            err = 1'b1;
            if (in == 1'b1) begin
                next_state = ERROR;
            end
            else if (in == 1'b0) begin
                next_state = IDLE;
            end
        end
    endcase

    if (state == ONECOUNT && in == 1'b1) begin
        if (next_state == ONECOUNT) begin
            if (next_state == ONECOUNT) begin
                next_state = ONECOUNT;
            end
            else begin
                next_state = FLAG;
            end
        end
        else begin
            next_state = ERROR;
        end
    end
end

endmodule
