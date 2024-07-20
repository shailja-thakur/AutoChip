module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [2:0] state;
    reg [3:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            delay <= 0;
            counter <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case(state)
                0: if (data == 1) state <= 1;
                1: if (data == 1) state <= 2; else state <= 0;
                2: if (data == 1) state <= 3; else state <= 0;
                3: if (data == 0) state <= 0; else if (data == 1) begin
                        delay <= data;
                        state <= 4;
                    end
                4: if (data == 1) begin
                        delay <= delay << 1;
                        state <= 5;
                    end
                5: if (data == 1) begin
                        delay <= delay << 1;
                        state <= 6;
                    end
                6: if (data == 0) state <= 0; else if (data == 1) begin
                        delay <= delay << 1;
                        state <= 7;
                    end
                7: if (data == 1) begin
                        delay <= delay << 1;
                        counting <= 1;
                        state <= 8;
                    end
                8: counter <= counter + 1;
            endcase
        end
    end

    always @(posedge clk) begin
        if (counter == (delay+1)*1000) begin
            counting <= 0;
            done <= 1;
        end
        count <= counting ? delay : 0;
    end

    always @(posedge clk) begin
        if (done && ack) begin
            state <= 0;
            delay <= 0;
            counter <= 0;
            counting <= 0;
            done <= 0;
        end
    end
endmodule
