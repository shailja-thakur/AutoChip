module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [3:0] state;

    parameter START = 2'b00;
    parameter SHIFT = 2'b01;
    parameter WAIT = 2'b10;
    parameter NOTIFY = 2'b11;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= START;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                START:
                    if (data == 4'b1101) begin
                        state <= SHIFT;
                        shift_ena <= 1;
                    end else begin
                        state <= START;
                        shift_ena <= 0;
                    end
                SHIFT:
                    if (shift_ena) begin
                        state <= WAIT;
                        shift_ena <= 0;
                        counting <= 1;
                    end else begin
                        state <= SHIFT;
                        shift_ena <= 0;
                    end
                WAIT:
                    if (done_counting) begin
                        state <= NOTIFY;
                        counting <= 0;
                        done <= 1;
                    end else begin
                        state <= WAIT;
                        counting <= 1;
                    end
                NOTIFY:
                    if (ack) begin
                        state <= START;
                        done <= 0;
                    end else begin
                        state <= NOTIFY;
                        done <= 1;
                    end
            endcase
        end
    end
endmodule
