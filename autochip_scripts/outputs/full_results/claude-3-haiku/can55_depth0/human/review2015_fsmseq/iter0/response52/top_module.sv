module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    parameter IDLE = 2'b00;
    parameter SEARCH = 2'b01;
    parameter FOUND = 2'b10;

    reg [1:0] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state == FOUND)
                start_shifting <= 1'b1;
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (data == 1'b1)
                    next_state = SEARCH;
                else
                    next_state = IDLE;
            end
            SEARCH: begin
                if (data == 1'b1)
                    next_state = SEARCH;
                else if (data == 1'b0)
                    next_state = IDLE;
                else if (data == 1'b1)
                    next_state = SEARCH;
                else if (data == 1'b0)
                    next_state = FOUND;
            end
            FOUND: begin
                next_state = FOUND;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
