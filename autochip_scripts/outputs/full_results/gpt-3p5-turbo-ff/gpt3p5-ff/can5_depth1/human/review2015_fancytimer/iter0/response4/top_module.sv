module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [2:0] state;
    reg [3:0] counter;
    reg [1:0] remaining_time;

    parameter IDLE = 0;
    parameter SEARCHING = 1;
    parameter COUNTING = 2;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            delay <= 0;
            counter <= 0;
            counting <= 0;
            done <= 0;
            remaining_time <= 0;
        end else begin
            case(state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= SEARCHING;
                        delay <= data[3:0];
                    end
                end

                SEARCHING: begin
                    state <= COUNTING;
                    counting <= 1;
                    counter <= (delay + 1) * 1000;
                end

                COUNTING: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                        if (remaining_time == 0) begin
                            remaining_time <= delay;
                        end else begin
                            remaining_time <= remaining_time - 1;
                        end
                    end else begin
                        counting <= 0;
                        done <= 1;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

    assign count = counting ? remaining_time : 4'bxxxx;

endmodule
