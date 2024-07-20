module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    parameter IDLE = 2'b00, SEARCH_1 = 2'b01, SEARCH_0 = 2'b10, FOUND = 2'b11;
    reg [1:0] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 0;
        end
        else begin
            state <= next_state;
            if (state == FOUND)
                start_shifting <= 1;
        end
    end

    always @(*) begin
        case (state)
            IDLE:
                if (data == 1)
                    next_state = SEARCH_1;
                else
                    next_state = IDLE;
            SEARCH_1:
                if (data == 1)
                    next_state = SEARCH_0;
                else
                    next_state = IDLE;
            SEARCH_0:
                if (data == 0)
                    next_state = SEARCH_1;
                else
                    next_state = IDLE;
            FOUND:
                next_state = FOUND;
            default:
                next_state = IDLE;
        endcase
    end

endmodule
