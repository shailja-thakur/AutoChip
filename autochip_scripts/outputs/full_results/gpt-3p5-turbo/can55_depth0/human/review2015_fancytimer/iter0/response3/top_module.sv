module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [1:0] state;
    reg [1:0] nextState;
    reg [2:0] countMsb;
    reg [9:0] countLsb;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            state <= 0;
            delay <= 0;
            countMsb <= 0;
            countLsb <= 0;
        end else begin
            case (state)
                0: begin // Searching for input sequence 1101
                    if (data == 4'b1101) begin
                        state <= 1;
                        delay <= data[3:0];
                    end
                end
                1: begin // Shifting in 4 bits to determine delay
                    if (countMsb < 2) begin
                        countMsb <= countMsb + 1;
                    end else begin
                        countMsb <= 0;
                        nextState <= 2;
                    end
                end
                2: begin // Counting for (delay[3:0] + 1) * 1000 cycles
                    if (countLsb < 999) begin
                        countLsb <= countLsb + 1;
                    end else begin
                        countLsb <= 0;
                        if (countMsb < delay) begin
                            countMsb <= countMsb + 1;
                            nextState <= 2;
                        end else begin
                            countMsb <= 0;
                            nextState <= 3;
                        end
                    end
                end
                3: begin // Done counting, waiting for ack
                    counting <= 0;
                    done <= 1;
                    if (ack) begin
                        done <= 0;
                        state <= 0;
                    end
                end
            endcase
        end
    end
    
    assign count = counting ? countMsb + delay : 4'b0;
    
endmodule
