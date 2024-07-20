module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    parameter IDLE = 2'd0;
    parameter SEARCH_1 = 2'd1;
    parameter SEARCH_10 = 2'd2;
    parameter SEARCH_101 = 2'd3;

    reg [1:0] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state == SEARCH_101 && data == 1'b1) begin
                start_shifting <= 1'b1;
            end
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = SEARCH_1;
                end
                else begin
                    next_state = IDLE;
                end
            end
            SEARCH_1: begin
                if (data == 1'b1) begin
                    next_state = SEARCH_10;
                end
                else begin
                    next_state = IDLE;
                end
            end
            SEARCH_10: begin
                if (data == 1'b0) begin
                    next_state = SEARCH_101;
                end
                else begin
                    next_state = IDLE;
                end
            end
            SEARCH_101: begin
                if (data == 1'b1) begin
                    next_state = SEARCH_101;
                end
                else begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
