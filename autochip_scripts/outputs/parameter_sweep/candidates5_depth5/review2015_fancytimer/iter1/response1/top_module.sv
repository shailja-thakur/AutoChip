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
    reg [19:0] counter;
    reg [1:0] remaining_time;

    // Constants
    parameter IDLE = 2'b00;
    parameter DETECTING = 2'b01;
    parameter COUNTING = 2'b10;

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
                        remaining_time <= remaining_time - 1;
                        counting <= 1;
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

    // Wait for ack to reset
    always @(posedge clk) begin
        if (ack && done) begin
            done <= 0;
            counter <= 0;
            remaining_time <= 0;
        end
    end

endmodule
