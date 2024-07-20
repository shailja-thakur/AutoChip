module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    parameter IDLE = 2'b00;
    parameter FOUND_1 = 2'b01;
    parameter FOUND_11 = 2'b10;
    parameter FOUND_1101 = 2'b11;

    reg [1:0] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 0;
        end else begin
            state <= next_state;
            if (state == FOUND_1101)
                start_shifting <= 1;
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (data == 1)
                    next_state = FOUND_1;
                else
                    next_state = IDLE;
            end
            FOUND_1: begin
                if (data == 1)
                    next_state = FOUND_11;
                else
                    next_state = IDLE;
            end
            FOUND_11: begin
                if (data == 0)
                    next_state = FOUND_1101;
                else
                    next_state = FOUND_1;
            end
            FOUND_1101: begin
                next_state = FOUND_1101;
            end
        endcase
    end

endmodule
