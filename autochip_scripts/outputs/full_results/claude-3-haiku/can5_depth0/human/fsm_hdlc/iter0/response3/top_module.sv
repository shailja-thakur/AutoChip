module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter [2:0] IDLE = 3'b000,
                WAIT_1 = 3'b001,
                WAIT_5 = 3'b010,
                FLAG = 3'b011,
                ERROR = 3'b100;

reg [2:0] state, next_state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (state)
        IDLE: begin
            if (in == 1'b1)
                next_state = WAIT_1;
            else
                next_state = IDLE;
        end
        WAIT_1: begin
            if (in == 1'b1)
                next_state = WAIT_5;
            else
                next_state = IDLE;
        end
        WAIT_5: begin
            count = count + 1;
            if (in == 1'b1 && count == 3'd5)
                next_state = FLAG;
            else if (in == 1'b1)
                next_state = WAIT_5;
            else begin
                next_state = IDLE;
                disc = 1'b1;
            end
        end
        FLAG: begin
            if (in == 1'b1)
                next_state = ERROR;
            else begin
                next_state = IDLE;
                flag = 1'b1;
            end
        end
        ERROR: begin
            err = 1'b1;
            next_state = IDLE;
        end
        default: next_state = IDLE;
    endcase
end

endmodule
