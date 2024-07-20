module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // Internal signals
    reg [1:0] state;
    reg [3:0] delay;
    reg [11:0] counter;
    reg [3:0] remaining_time;

    // Constants
    parameter IDLE = 2'b00;
    parameter DETECTING = 2'b01;
    parameter COUNTING = 2'b10;

    // State machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            counter <= 0;
            remaining_time <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= DETECTING;
                        counting <= 0;
                    end
                end

                DETECTING: begin
                    delay <= data;
                    state <= COUNTING;
                    counter <= (delay + 1) * 1000 - 1;
                    remaining_time <= delay;
                end

                COUNTING: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                        counting <= 1;
                    end else begin
                        counting <= 0;
                        if (ack) begin
                            state <= IDLE;
                            done <= 1;
                        end
                    end
                end
            endcase
        end
    end

    // Output assignment
    assign count = counting ? remaining_time : 4'bxxxx;

endmodule
