module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter IDLE = 2'b00, DETECT_1 = 2'b01, DETECT_5 = 2'b10, DETECT_6 = 2'b11;
reg [1:0] state, next_state;
reg [2:0] count;

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
            if (in)
                next_state = DETECT_1;
        end
        DETECT_1: begin
            if (in)
                next_state = DETECT_5;
            else
                next_state = IDLE;
        end
        DETECT_5: begin
            if (in)
                count = count + 1;
            else
                count = 0;

            if (count == 3'b101)
                next_state = DETECT_6;
            else
                next_state = DETECT_5;
        end
        DETECT_6: begin
            if (in) begin
                disc = 1;
                next_state = DETECT_1;
            end
            else begin
                flag = 1;
                next_state = IDLE;
            end
        end
    endcase

    if (state == DETECT_5 && count == 3'b111)
        err = 1;
end

endmodule
