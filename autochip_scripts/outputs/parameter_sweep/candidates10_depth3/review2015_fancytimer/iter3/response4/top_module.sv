module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [2:0] state;
    reg [15:0] counter;

    // State machine states
    localparam IDLE = 2'b00;
    localparam START = 2'b01;
    localparam SHIFT = 2'b10;
    localparam COUNT = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 4'b0;
            counting <= 0;
            done <= 0;
            counter <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= SHIFT;
                    end
                end
                SHIFT: begin
                    state <= COUNT;
                    delay <= data;
                    counter <= 0;
                    count <= delay;
                end
                COUNT: begin
                    if (counter == (delay + 1) * 1000 - 1) begin
                        if (delay == 0) begin
                            state <= IDLE;
                            done <= 1;
                        end else begin
                            delay <= delay - 1;
                            counter <= 0;
                            count <= delay;
                        end
                    end else begin
                        counter <= counter + 1;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
        end else begin
            case (state)
                COUNT: begin
                    counting <= 1;
                end
                default: begin
                    counting <= 0;
                end
            endcase
        end
    end

endmodule
