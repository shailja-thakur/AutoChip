module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] counter;
    wire start_seq;

    assign start_seq = (data == 4'b1101);

    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            delay <= 0;
            counter <= 0;
        end else begin
            if (start_seq && !counting) begin
                counting <= 1;
                delay <= data[3:0];
                counter <= (delay + 1) * 1000;
            end else if (counter > 0) begin
                counting <= 1;
                counter <= counter - 1;
            end else if (counter == 0) begin
                counting <= 0;
                done <= 1;
            end else begin
                counting <= 0;
            end
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
        end else if (counting) begin
            count <= delay;
        end else begin
            count <= 0;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
        end else if (done && ack) begin
            done <= 0;
        end
    end

endmodule
