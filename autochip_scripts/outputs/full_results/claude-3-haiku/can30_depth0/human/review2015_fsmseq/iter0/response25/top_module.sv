module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] IDLE = 2'b00, SEARCH_1 = 2'b01, SEARCH_01 = 2'b10, SEARCH_101 = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (data == 1)
                next_state = SEARCH_1;
        end
        SEARCH_1: begin
            if (data == 0)
                next_state = SEARCH_01;
            else
                next_state = IDLE;
        end
        SEARCH_01: begin
            if (data == 1)
                next_state = SEARCH_101;
            else
                next_state = IDLE;
        end
        SEARCH_101: begin
            if (data == 1)
                next_state = SEARCH_101;
            else
                next_state = IDLE;
        end
    endcase
end

always @(posedge clk) begin
    if (reset)
        start_shifting <= 0;
    else if (state == SEARCH_101 && data == 0)
        start_shifting <= 1;
end

endmodule
