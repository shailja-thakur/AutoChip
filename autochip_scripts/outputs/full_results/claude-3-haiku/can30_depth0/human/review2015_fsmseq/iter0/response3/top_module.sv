module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    localparam [1:0] IDLE = 2'b00,
                    FOUND_1 = 2'b01,
                    FOUND_10 = 2'b10,
                    FOUND_101 = 2'b11;

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
                start_shifting = 0;
                if (data == 1)
                    next_state = FOUND_1;
                else
                    next_state = IDLE;
            end
            FOUND_1: begin
                start_shifting = 0;
                if (data == 0)
                    next_state = FOUND_10;
                else
                    next_state = IDLE;
            end
            FOUND_10: begin
                start_shifting = 0;
                if (data == 1)
                    next_state = FOUND_101;
                else
                    next_state = IDLE;
            end
            FOUND_101: begin
                start_shifting = 1;
                next_state = FOUND_101;
            end
            default: begin
                start_shifting = 0;
                next_state = IDLE;
            end
        endcase
    end

endmodule
