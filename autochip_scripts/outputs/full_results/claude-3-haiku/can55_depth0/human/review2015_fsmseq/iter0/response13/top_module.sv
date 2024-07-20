module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

parameter IDLE = 2'b00;
parameter SEARCH_1 = 2'b01;
parameter SEARCH_10 = 2'b10;
parameter SEARCH_101 = 2'b11;

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
            if (data == 1'b1)
                next_state = SEARCH_1;
            else
                next_state = IDLE;
        end
        SEARCH_1: begin
            if (data == 1'b1)
                next_state = SEARCH_10;
            else
                next_state = IDLE;
        end
        SEARCH_10: begin
            if (data == 1'b1)
                next_state = SEARCH_101;
            else
                next_state = IDLE;
        end
        SEARCH_101: begin
            if (data == 1'b1)
                next_state = SEARCH_1;
            else
                next_state = IDLE;
        end
        default: next_state = IDLE;
    endcase
end

always @(posedge clk) begin
    if (reset)
        start_shifting <= 1'b0;
    else if (state == SEARCH_101 && data == 1'b1)
        start_shifting <= 1'b1;
end

endmodule
