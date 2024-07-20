module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state, next_state;
parameter IDLE = 3'b000, DISC1 = 3'b001, DISC2 = 3'b010, FLAG = 3'b011, ERR = 3'b100;

always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    disc = 0;
    flag = 0;
    err = 0;

    case (state)
        IDLE: begin
            if (in == 1'b1)
                next_state = DISC1;
        end
        DISC1: begin
            if (in == 1'b1)
                next_state = DISC2;
            else
                next_state = IDLE;
        end
        DISC2: begin
            if (in == 1'b1) begin
                next_state = IDLE;
                disc = 1;
            end
            else
                next_state = IDLE;
        end
        FLAG: begin
            if (in == 1'b1)
                next_state = ERR;
            else
                next_state = IDLE;
            flag = 1;
        end
        ERR: begin
            if (in == 1'b0)
                next_state = IDLE;
            else
                next_state = ERR;
            err = 1;
        end
        default:
            next_state = IDLE;
    endcase
end

endmodule
