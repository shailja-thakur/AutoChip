module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    parameter STATE_IDLE = 3'b000;
    parameter STATE_1 = 3'b001;
    parameter STATE_10 = 3'b011;
    parameter STATE_101 = 3'b010;
    parameter STATE_1101 = 3'b110;

    reg [2:0] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_IDLE;
            start_shifting <= 1'b0;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            STATE_IDLE: begin
                if (data == 1'b1)
                    next_state = STATE_1;
                else
                    next_state = STATE_IDLE;
                start_shifting = 1'b0;
            end
            STATE_1: begin
                if (data == 1'b0)
                    next_state = STATE_10;
                else
                    next_state = STATE_1;
                start_shifting = 1'b0;
            end
            STATE_10: begin
                if (data == 1'b1)
                    next_state = STATE_101;
                else
                    next_state = STATE_IDLE;
                start_shifting = 1'b0;
            end
            STATE_101: begin
                if (data == 1'b1)
                    next_state = STATE_1101;
                else
                    next_state = STATE_IDLE;
                start_shifting = 1'b0;
            end
            STATE_1101: begin
                next_state = STATE_1101;
                start_shifting = 1'b1;
            end
            default: begin
                next_state = STATE_IDLE;
                start_shifting = 1'b0;
            end
        endcase
    end

endmodule
