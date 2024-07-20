module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] remaining_time;
    reg [3:0] state;

    parameter STOP = 4'b0000;
    parameter SHIFT_IN = 4'b0001;
    parameter COUNTING = 4'b0010;
    parameter DONE = 4'b0011;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STOP;
            counting <= 0;
            done <= 0;
            remaining_time <= 0;
        end else begin
            case (state)
                STOP: begin
                    if (data == 4'b1101) begin
                        delay <= data[3:0];
                        state <= SHIFT_IN;
                    end else begin
                        delay <= 0;
                        state <= STOP;
                    end
                end
                SHIFT_IN: begin
                    state <= COUNTING;
                    remaining_time <= delay;
                end
                COUNTING: begin
                    counting <= 1;
                    if (remaining_time == 0) begin
                        state <= DONE;
                    end else begin
                        remaining_time <= remaining_time - 1;
                    end
                end
                DONE: begin
                    counting <= 0;
                    done <= 1;
                    if (ack) begin
                        state <= STOP;
                    end
                end
                default: state <= STOP;
            endcase
        end
    end

    always @(posedge clk) begin
        count <= counting ? remaining_time : 4'bxxxx;
    end

endmodule
