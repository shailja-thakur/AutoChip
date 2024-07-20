module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] current_count;
    reg [3:0] remaining_time;
    reg [3:0] state;
    reg searching;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            delay <= 0;
            current_count <= 0;
            remaining_time <= 0;
            state <= 0;
            counting <= 0;
            done <= 0;
            searching <= 1;
        end else begin
            if (searching) begin
                if (data == 4'b1101) begin
                    delay <= data[3:0];
                    searching <= 0;
                    counting <= 1;
                    current_count <= 0;
                    state <= 1;
                end
            end else if (counting) begin
                current_count <= current_count + 1;
                if (current_count >= (delay + 1) * 1000) begin
                    counting <= 0;
                    done <= 1;
                end
                if (current_count % 1000 == 0) begin
                    remaining_time <= delay - (current_count / 1000);
                end
            end
        end
    end

    always @(posedge clk) begin
        if (ack) begin
            delay <= 0;
            current_count <= 0;
            remaining_time <= 0;
            done <= 0;
            searching <= 1;
        end
    end

    assign count = remaining_time;

endmodule
