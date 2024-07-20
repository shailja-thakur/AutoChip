module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] remaining;

    parameter IDLE = 2'b00;
    parameter DETECTING = 2'b01;
    parameter COUNTING = 2'b10;

    reg [1:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        delay <= data[3:0];
                        remaining <= data[3:0];
                        state <= DETECTING;
                    end
                end
                DETECTING: begin
                    state <= COUNTING;
                    counting <= 1;
                end
                COUNTING: begin
                    if (remaining == 0) begin
                        counting <= 0;
                        done <= 1;
                        if (ack) begin
                            state <= IDLE;
                            done <= 0;
                        end
                    end else begin
                        remaining <= remaining - 1;
                    end
                end
                default: begin
                    state <= IDLE;
                    counting <= 0;
                    done <= 0;
                end
            endcase
        end
    end

    assign count = counting ? remaining : 4'bXXXX;

endmodule
