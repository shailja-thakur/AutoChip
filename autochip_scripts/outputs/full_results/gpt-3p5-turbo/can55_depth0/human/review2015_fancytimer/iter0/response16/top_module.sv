module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] count_reg;
    reg [3:0] remaining_time;
    reg [3:0] next_remaining_time;

    parameter IDLE = 2'b00;
    parameter START = 2'b01;
    parameter COUNT = 2'b10;

    reg [1:0] state;
    reg [1:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            delay <= 4'b0;
            count_reg <= 4'b0;
            remaining_time <= 4'b0;
            next_remaining_time <= 4'b0;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            delay <= data;
            count_reg <= count_reg;
            remaining_time <= next_remaining_time;
            counting <= (state == COUNT);
            done <= (state == IDLE) && ack;
        end
    end

    always @(state or delay) begin
        next_state = state;
        next_remaining_time = remaining_time;

        case (state)
            IDLE: begin
                if (data == 4'b1101) begin
                    next_state = START;
                    next_remaining_time = delay + 1;
                end
            end

            START: begin
                next_state = COUNT;
                next_remaining_time = delay;
            end

            COUNT: begin
                if (remaining_time > 0) begin
                    next_state = COUNT;
                    next_remaining_time = remaining_time - 1;
                end else begin
                    next_state = IDLE;
                    next_remaining_time = delay;
                end
            end
        endcase
    end

    always @(posedge clk) begin
        if (state == COUNT && remaining_time != 0) begin
            count_reg <= count_reg + 1;
        end
    end

    assign count = counting ? count_reg : 4'b0;

endmodule
