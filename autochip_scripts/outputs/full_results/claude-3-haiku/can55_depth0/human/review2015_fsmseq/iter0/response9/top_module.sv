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

reg [1:0] current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
        start_shifting <= 0;
    end
    else begin
        current_state <= next_state;
        if (current_state == SEARCH_101 && data == 1)
            start_shifting <= 1;
    end
end

always @(*) begin
    case (current_state)
        IDLE: begin
            if (data == 1)
                next_state = SEARCH_1;
            else
                next_state = IDLE;
        end
        SEARCH_1: begin
            if (data == 1)
                next_state = SEARCH_10;
            else
                next_state = IDLE;
        end
        SEARCH_10: begin
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
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
