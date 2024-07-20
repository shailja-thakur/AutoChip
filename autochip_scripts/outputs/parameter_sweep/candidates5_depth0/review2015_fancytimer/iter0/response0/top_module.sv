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
    reg [2:0] state;
    reg start_sequence_detected;
    reg [3:0] shift_register;

    // State definitions
    parameter IDLE = 3'b000;
    parameter DETECT_START = 3'b001;
    parameter SHIFT_IN = 3'b010;
    parameter COUNT = 3'b011;
    parameter WAIT_FOR_ACK = 3'b100;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            start_sequence_detected <= 0;
            state <= IDLE;
            counting <= 0;
            done <= 0;
            shift_register <= 0;
            remaining_time <= 0;
        end else begin
            case (state)
                IDLE: begin
                    counting <= 0;
                    done <= 0;
                    if (data == 4'b1101) begin
                        state <= DETECT_START;
                        start_sequence_detected <= 1;
                    end
                end
                DETECT_START: begin
                    counting <= 0;
                    done <= 0;
                    if (data == 4'b1101) begin
                        shift_register <= {shift_register[2:0], data[0]};
                        state <= SHIFT_IN;
                    end else begin
                        shift_register <= 0;
                        state <= IDLE;
                        start_sequence_detected <= 0;
                    end
                end
                SHIFT_IN: begin
                    counting <= 0;
                    done <= 0;
                    shift_register <= {shift_register[2:0], data[0]};
                    delay <= shift_register;
                    state <= COUNT;
                end
                COUNT: begin
                    if (counting) begin
                        counting <= 0;
                        remaining_time <= delay;
                        done <= 0;
                    end else begin
                        counting <= 1;
                        remaining_time <= delay;
                        done <= 0;
                        state <= WAIT_FOR_ACK;
                    end
                end
                WAIT_FOR_ACK: begin
                    counting <= 0;
                    remaining_time <= delay;
                    if (ack) begin
                        done <= 1;
                        state <= IDLE;
                        start_sequence_detected <= 0;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (counting) begin
            if (remaining_time == 0) begin
                counting <= 0;
            end else begin
                remaining_time <= remaining_time - 1;
            end
        end
    end

    assign count = counting ? remaining_time : 0;

endmodule
