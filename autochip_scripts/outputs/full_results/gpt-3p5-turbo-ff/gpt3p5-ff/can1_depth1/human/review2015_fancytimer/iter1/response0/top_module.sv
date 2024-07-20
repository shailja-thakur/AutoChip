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

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            state <= 0;
            delay <= 0;
        end else begin
            case (state)
                0: begin
                    if (data == 1) begin
                        state <= 1;
                    end
                end
                1: begin
                    if (data == 1) begin
                        state <= 2;
                        counting <= 1;
                    end else begin
                        state <= 0;
                    end
                end
                2: begin
                    delay <= data;
                    state <= 3;
                end
                3: begin
                    if (count >= ((delay + 1) * 1000)) begin
                        counting <= 0;
                        done <= 1;
                        state <= 4;
                    end
                end
                4: begin
                    if (ack) begin
                        state <= 0;
                        done <= 0;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (counting && count > 0) begin
            count <= count - 1;
        end else if (counting) begin
            count <= delay;
        end
    end

endmodule
