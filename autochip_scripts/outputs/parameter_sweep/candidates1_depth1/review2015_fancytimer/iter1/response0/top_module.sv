module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] count_reg;
    reg [3:0] remaining_time;
    reg start;
    reg [3:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            start <= 0;
            delay <= 0;
            count_reg <= 0;
            remaining_time <= 0;
            state <= 0;
        end else begin
            if (state == 0 && data == 1 && #(delay + 1) * 1000) begin
                start <= 1;
                counting <= 0;
                done <= 0;
                delay <= data[3:0];
                count_reg <= #(delay + 1) * 1000;
                remaining_time <= delay + 1;
                state <= 1;
            end else if (state == 1) begin
                if (count_reg == 0) begin
                    start <= 0;
                    counting <= 1;
                    done <= 0;
                    delay <= 0;
                    count_reg <= 1000;
                    remaining_time <= delay;
                end else begin
                    start <= 0;
                    counting <= 0;
                    done <= 0;
                    delay <= 0;
                    count_reg <= count_reg - 1;
                    remaining_time <= remaining_time - (count_reg == 0);
                    state <= 2;
                end
            end else if (state == 2) begin
                if (remaining_time == 0 && ack == 1) begin
                    counting <= 0;
                    done <= 1;
                    delay <= 0;
                    count_reg <= 0;
                    remaining_time <= 0;
                    state <= 0;
                end
            end
        end
    end

    always @(posedge clk) begin
        count <= counting ? remaining_time : 4'b0;
    end

endmodule
