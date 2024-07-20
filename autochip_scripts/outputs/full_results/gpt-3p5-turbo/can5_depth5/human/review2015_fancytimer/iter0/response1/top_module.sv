module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [29:0] counter;
    reg [3:0] remaining_time;
    reg [3:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            delay <= 0;
            counter <= 0;
            remaining_time <= 0;
            state <= 0;
        end else begin
            case(state)
                4'b0000: begin // Waiting for start sequence 1101
                    if (data == 4'b1101) begin
                        state <= 4'b0001;
                        counting <= 1;
                        delay <= data[3:0];
                        counter <= 0;
                        remaining_time <= delay;
                    end else begin
                        counting <= 0;
                        done <= 0;
                    end
                end
                4'b0001: begin // Shift in 4 bits for delay
                    if (counter < 4) begin
                        counter <= counter + 1;
                        delay <= {delay[2:0], data};
                    end else begin
                        state <= 4'b0010;
                        counter <= 0;
                    end
                end
                4'b0010: begin // Counting
                    if (counter < ((delay + 1) * 1000) - 1) begin
                        counter <= counter + 1;
                    end else begin
                        state <= 4'b0011;
                        counter <= 0;
                    end
                end
                4'b0011: begin // Remaining time
                    if (counter < 1000 - 1) begin
                        counter <= counter + 1;
                        remaining_time <= delay - (counter/1000);
                    end else begin
                        if (ack) begin
                            state <= 4'b0000;
                            counting <= 0;
                            done <= 1;
                        end
                        counter <= 0;
                    end
                end
            endcase
        end
    end

    assign count = counting ? remaining_time : 4'bxxxx;

endmodule
