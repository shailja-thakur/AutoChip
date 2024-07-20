module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state, next_state;
parameter IDLE = 3'b000, FIVE_ONES = 3'b001, FLAG = 3'b010, ERROR = 3'b011;

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
                next_state = FIVE_ONES;
            end
        end
        FIVE_ONES: begin
            if (in == 1'b1) begin
                next_state = FLAG;
            end
            else begin
                next_state = IDLE;
            end
        end
        FLAG: begin
            if (in == 1'b1) begin
                next_state = ERROR;
                err = 1'b1;
            end
            else begin
                next_state = IDLE;
                disc = 1'b0;
                flag = 1'b1;
            end
        end
        ERROR: begin
            if (in == 1'b1) begin
                next_state = ERROR;
            end
            else begin
                next_state = IDLE;
                err = 1'b1;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
