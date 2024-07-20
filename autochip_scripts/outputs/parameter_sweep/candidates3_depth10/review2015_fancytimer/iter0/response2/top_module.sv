module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // Internal signals
    reg [3:0] delay;
    reg [3:0] counter;
    reg [3:0] remaining_time;
    reg [3:0] state;

    // Parameter for the start pattern
    localparam [3:0] START_PATTERN = 4'b1101;

    // State definitions
    localparam IDLE_STATE = 2'b00;      // Idle state, waiting for start pattern
    localparam SHIFT_STATE = 2'b01;     // Shift state, shifting in the delay value
    localparam COUNT_STATE = 2'b10;     // Count state, counting down the delay
    localparam DONE_STATE = 2'b11;      // Done state, waiting for ack
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE_STATE;
            counting <= 0;
            done <= 0;
            counter <= 0;
            remaining_time <= 0;
        end else begin
            case (state)
                IDLE_STATE:
                    if (data == START_PATTERN) begin
                        delay <= data[3:0];
                        state <= SHIFT_STATE;
                    end
                SHIFT_STATE:
                    state <= COUNT_STATE;
                COUNT_STATE:
                    if (counter == (delay + 1) * 1000) begin
                        counting <= 0;
                        state <= DONE_STATE;
                    end else begin
                        if (counter % 1000 == 0) begin
                            remaining_time <= delay - ((counter / 1000) - 1);
                        end
                        counter <= counter + 1;
                    end
                DONE_STATE:
                    if (ack) begin
                        state <= IDLE_STATE;
                        done <= 1;
                    end
            endcase
        end
    end

    assign count = counting ? remaining_time : 4'bx;

endmodule
