module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg[3:0] delay;
    reg[3:0] counter;
    reg[3:0] remaining;

    enum logic [2:0] states;
    parameter WAIT = 3'd0;
    parameter SHIFT = 3'd1;
    parameter COUNT = 3'd2;
    parameter DONE = 3'd3;

    reg [2:0] state;
    reg [3:0] pattern_buffer;
    reg start_detected;

    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT;
            start_detected <= 0;
            counting <= 0;
            done <= 0;
            delay <= 0;
            counter <= 0;
            remaining <= 0;
        end else begin
            case (state)
                WAIT: begin
                    if (data) begin
                        pattern_buffer <= {pattern_buffer[2:0], data};
                        if (pattern_buffer == 4'b1101) begin
                            start_detected <= 1;
                            state <= SHIFT;
                        end
                    end
                end
                SHIFT: begin
                    delay <= {delay[2:0], data};
                    counter <= (delay + 1) * 1000;
                    state <= COUNT;
                    counting <= 1;
                end
                COUNT: begin
                    if (counter == 0) begin
                        state <= DONE;
                        counting <= 0;
                        done <= 1;
                    end else begin
                        counter <= counter - 1;
                    end
                    remaining <= counter / 1000;
                end
                DONE: begin
                    if (ack) begin
                        state <= WAIT;
                        start_detected <= 0;
                        counting <= 0;
                        done <= 0;
                        delay <= 0;
                        counter <= 0;
                        remaining <= 0;
                    end
                end
            endcase
        end
    end

    assign count = counting ? remaining : 4'bxxxx;

endmodule
