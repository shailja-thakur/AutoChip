module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define states
    localparam WAITING_START = 0;
    localparam SHIFTING = 1;
    localparam COUNT_WAIT = 2;
    localparam NOTIFIED = 3;

    reg [1:0] state;
    reg [3:0] count;

    always @(posedge clk) begin
        if (reset) begin
            state <= WAITING_START;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            count <= 0;
        end else begin
            case(state)
                WAITING_START: begin
                    if (data == 4'b1101) begin
                        state <= SHIFTING;
                        shift_ena <= 1;
                        count <= 0;
                    end else begin
                        shift_ena <= 0;
                    end
                end
                SHIFTING: begin
                    if (count == 4) begin
                        state <= COUNT_WAIT;
                        shift_ena <= 0;
                        counting <= 1;
                    end else begin
                        count <= count + 1;
                    end
                end
                COUNT_WAIT: begin
                    if (done_counting) begin
                        state <= NOTIFIED;
                        counting <= 0;
                        done <= 1;
                    end
                end
                NOTIFIED: begin
                    if (ack) begin
                        state <= WAITING_START;
                        done <= 0;
                    end
                end
            endcase
        end
    end
endmodule
