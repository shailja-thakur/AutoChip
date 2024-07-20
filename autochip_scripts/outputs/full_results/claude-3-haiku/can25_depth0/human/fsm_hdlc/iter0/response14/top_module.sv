module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

`define IDLE 3'd0
`define WAIT_ONE 3'd1
`define WAIT_TWO 3'd2
`define WAIT_THREE 3'd3
`define WAIT_FOUR 3'd4
`define WAIT_FIVE 3'd5
`define WAIT_SIX 3'd6
`define ERROR 3'd7

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= `IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (state)
        `IDLE: begin
            if (in == 1'b1) begin
                next_state = `WAIT_ONE;
            end
            else begin
                next_state = `IDLE;
            end
        end
        `WAIT_ONE: begin
            if (in == 1'b1) begin
                next_state = `WAIT_TWO;
            end
            else begin
                next_state = `IDLE;
            end
        end
        `WAIT_TWO: begin
            if (in == 1'b1) begin
                next_state = `WAIT_THREE;
            end
            else begin
                next_state = `IDLE;
            end
        end
        `WAIT_THREE: begin
            if (in == 1'b1) begin
                next_state = `WAIT_FOUR;
            end
            else begin
                next_state = `IDLE;
            end
        end
        `WAIT_FOUR: begin
            if (in == 1'b1) begin
                next_state = `WAIT_FIVE;
            end
            else begin
                next_state = `IDLE;
            end
        end
        `WAIT_FIVE: begin
            if (in == 1'b1) begin
                next_state = `WAIT_SIX;
                disc = 1'b1;
            end
            else begin
                next_state = `IDLE;
            end
        end
        `WAIT_SIX: begin
            if (in == 1'b1) begin
                next_state = `ERROR;
                flag = 1'b1;
            end
            else begin
                next_state = `IDLE;
            end
        end
        `ERROR: begin
            if (in == 1'b1) begin
                next_state = `ERROR;
                err = 1'b1;
            end
            else begin
                next_state = `IDLE;
            end
        end
        default: begin
            next_state = `IDLE;
        end
    endcase
end

endmodule
