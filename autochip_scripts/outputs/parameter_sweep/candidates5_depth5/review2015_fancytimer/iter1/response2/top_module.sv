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
    reg [12:0] counter;
    reg [1:0] remaining_time;

    // Constants
    parameter IDLE = 2'd0;
    parameter DETECTING = 2'd1;
    parameter COUNTING = 2'd2;

    // State machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            delay <= 0;
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
                    counter <= (delay + 1) * 1000;
                    remaining_time <= delay;
                end

                COUNTING: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                        if (counter % 1000 == 0) begin
                            remaining_time <= remaining_time - 1;
                        end
                        counting <= 1;
                        done <= 0;
                    end else begin
                        state <= IDLE;
                        counting <= 0;
                        done <= 1;
                    end
                end
            endcase
        end
    end

    // Output assignment
    assign count = counting ? remaining_time : 4'bxxxx;

    // Reset and ack
    always @(posedge clk) begin
        if (ack && done) begin
            done <= 0;
            counter <= 0;
            remaining_time <= 0;
        end
    end

endmodule
