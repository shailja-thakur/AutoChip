module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [2:0] state;
    reg [3:0] delay;
    reg [13:0] counter;
    reg flag;
    reg [3:0] remaining_time;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            delay <= 0;
            counter <= 0;
            counting <= 0;
            done <= 0;
            flag <= 0;
            remaining_time <= 0;
        end else begin
            case (state)
                0: begin
                    if (data == 1 && flag) begin
                        state <= 1;
                        counting <= 1;
                    end else if (data == 1) begin
                        flag <= 1;
                    end
                end
                1: begin
                    delay <= {delay[2:0], data};
                    state <= 2;
                    counter <= 0;
                    remaining_time <= delay;
                end
                2: begin
                    if (counter == ((delay + 1) * 1000)) begin
                        counting <= 0;
                        done <= 1;
                        state <= 3;
                    end else begin
                        counter <= counter + 1;
                        if (counter % 1000 == 0) begin
                            remaining_time <= remaining_time - 1;
                        end
                    end
                end
                3: begin
                    if (ack == 1) begin
                        done <= 0;
                        state <= 0;
                        flag <= 0;
                    end
                end
            endcase
        end
    end

    assign count = counting ? remaining_time : 4'bx;

endmodule
