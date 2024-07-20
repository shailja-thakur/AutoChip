module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    parameter IDLE = 2'b00, SEARCH1 = 2'b01, SEARCH2 = 2'b10, SEARCH3 = 2'b11;
    reg [1:0] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 0;
        end
        else begin
            state <= next_state;
            if (state == SEARCH3)
                start_shifting <= 1;
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (data == 1)
                    next_state = SEARCH1;
                else
                    next_state = IDLE;
            end
            SEARCH1: begin
                if (data == 0)
                    next_state = SEARCH2;
                else
                    next_state = IDLE;
            end
            SEARCH2: begin
                if (data == 1)
                    next_state = SEARCH3;
                else
                    next_state = IDLE;
            end
            SEARCH3: begin
                if (data == 1)
                    next_state = SEARCH1;
                else
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
