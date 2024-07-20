module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output wire counting,
    output wire done,
    input wire ack );

    reg [1:0] state;
    reg [3:0] delay;
    reg [3:0] remaining_time;
    reg [15:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            counter <= 16'b0;
            delay <= 4'b0;
        end else begin
            case(state)
                2'b00: begin
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (data == 1'b1) begin
                        state <= 2'b01;
                    end
                end

                2'b01: begin
                    if (data == 1'b1) begin
                        state <= 2'b10;
                        counter <= 16'b0;
                    end else begin
                        state <= 2'b00;
                    end
                end

                2'b10: begin
                    counter <= counter + 1;
                    if (counter == 16'b111111111111) begin
                        counter <= 16'b0;
                        delay <= data[3:0];
                        state <= 2'b11;
                    end
                end

                2'b11: begin
                    counting <= 1'b1;
                    if (counter == ((delay + 1) * 16'b111111111111)) begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        state <= 2'b00;
                    end else begin
                        counter <= counter + 1;
                        remaining_time <= delay - (counter[11:8] / 4'b1111);
                    end
                end
            endcase
        end
    end

    assign count = (state == 2'b11) ? remaining_time : 4'bzzzz;

    always @(posedge clk) begin
        if (reset) begin
            remaining_time <= 4'b0;
        end else if (state == 2'b00) begin
            remaining_time <= delay;
        end
    end

endmodule
