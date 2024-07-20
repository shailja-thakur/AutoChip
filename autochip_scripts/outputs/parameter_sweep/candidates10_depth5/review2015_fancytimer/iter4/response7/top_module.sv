module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [13:0] counter;
    reg [1:0] state;
    reg flag;
    reg [3:0] remaining_time;

    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00;
            delay <= 4'b0000;
            counter <= 14'b0;
            counting <= 0;
            done <= 0;
            flag <= 0;
            remaining_time <= 4'b0000;
        end else begin
            case (state)
                2'b00: begin
                    if (data == 4'b1101 && flag) begin
                        state <= 2'b01;
                        counting <= 1;
                    end else if (data == 4'b1101) begin
                        flag <= 1;
                    end
                end
                2'b01: begin
                    state <= 2'b10;
                    counter <= 14'b0;
                    delay <= {data, delay[3:1]};
                    remaining_time <= delay;
                end
                2'b10: begin
                    if (counter >= ((delay + 1) * 1000)) begin
                        state <= 2'b11;
                        counting <= 0;
                        done <= 1;
                    end else begin
                        counter <= counter + 1;
                        if (counter % 1000 == 0) begin
                            remaining_time <= remaining_time - 1;
                        end
                    end
                end
                2'b11: begin
                    if (ack == 1) begin
                        state <= 2'b00;
                        done <= 0;
                        flag <= 0;
                    end
                end
            endcase
        end
    end

    assign count = counting ? remaining_time : 4'bzzzz;

endmodule
