module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack ); 

    reg [3:0] delay;
    reg [3:0] remaining;

    reg [3:0] state;
    reg [3:0] nextState;

    parameter START = 4'b0000;
    parameter SHIFT = 4'b0001;
    parameter COUNT = 4'b0010;
    parameter DONE = 4'b0011;

    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            state <= START;
            delay <= 0;
            remaining <= 0;
            count <= 0;
        end else begin
            state <= nextState;
            counting <= 0;
            done <= 0;
            count <= remaining;

            case (state)
                START:
                    if (data == 4'b1101) begin
                        nextState <= SHIFT;
                    end else begin
                        nextState <= START;
                    end
                SHIFT:
                    delay <= data;
                    remaining <= (delay + 1) * 1000;
                    nextState <= COUNT;
                COUNT:
                    if (remaining > 0) begin
                        counting <= 1;
                        remaining <= remaining - 1;
                        nextState <= COUNT;
                    end else begin
                        counting <= 0;
                        done <= 1;
                        nextState <= DONE;
                    end
                DONE:
                    if (ack == 1) begin
                        nextState <= START;
                    end else begin
                        nextState <= DONE;
                    end
                default:
                    nextState <= START;
            endcase
        end
    end
endmodule
