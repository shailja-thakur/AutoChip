module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    parameter IDLE = 2'b00;
    parameter DETECT_PATTERN = 2'b01;
    parameter SHIFT_IN = 2'b10;
    parameter COUNT = 2'b11;

    reg [1:0] state;
    reg [3:0] delay;
    reg [3:0] remaining_time;
    reg [12:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 13'b0;
            delay <= 4'b0;
        end else begin
            case(state)
                IDLE: begin
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (data == 1'b1) begin
                        state <= DETECT_PATTERN;
                    end
                end

                DETECT_PATTERN: begin
                    if (data == 1'b1) begin
                        state <= SHIFT_IN;
                        counter <= 13'b0;
                    end else begin
                        state <= IDLE;
                    end
                end

                SHIFT_IN: begin
                    counter <= counter + 1;
                    if (counter == 13'b1111111111111) begin
                        counter <= 13'b0;
                        delay <= data;
                        state <= COUNT;
                    end
                end

                COUNT: begin
                    counting <= 1'b1;
                    if (counter == ((delay + 1) * 1000)) begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        state <= IDLE;
                    end else begin
                        counter <= counter + 1;
                        remaining_time <= delay - (counter / 1000);
                    end
                end
            endcase
        end
    end

    assign count = (state == COUNT) ? remaining_time : 4'bzzzz;

    always @(posedge clk) begin
        if (reset) begin
            remaining_time <= 4'b0;
        end else if (state == IDLE) begin
            remaining_time <= delay;
        end
    end

endmodule
