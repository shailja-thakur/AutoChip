module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] IDLE = 2'b00, FIND_1 = 2'b01, FIND_10 = 2'b10, FIND_101 = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        IDLE: begin
            if (data == 1)
                next_state = FIND_1;
            else
                next_state = IDLE;
        end
        FIND_1: begin
            if (data == 0)
                next_state = FIND_10;
            else
                next_state = FIND_1;
        end
        FIND_10: begin
            if (data == 1)
                next_state = FIND_101;
            else
                next_state = IDLE;
        end
        FIND_101: begin
            if (data == 1)
                next_state = FIND_101;
            else
                next_state = IDLE;
        end
        default: next_state = IDLE;
    endcase
end

always @(posedge clk) begin
    if (reset)
        start_shifting <= 1'b0;
    else if (state == FIND_101)
        start_shifting <= 1'b1;
end

endmodule
