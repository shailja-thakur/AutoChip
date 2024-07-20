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
    reg [2:0] count;
    reg [3:0] shift_data;

    parameter IDLE = 2'b00;
    parameter DETECT_SEQUENCE = 2'b01;
    parameter SHIFT_IN = 2'b10;
    parameter WAIT_COUNT = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case(state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= DETECT_SEQUENCE;
                        shift_ena <= 0;
                    end else begin
                        state <= IDLE;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                    end
                end
                DETECT_SEQUENCE: begin
                    if (shift_ena == 4) begin
                        state <= SHIFT_IN;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                    end else begin
                        shift_ena <= shift_ena + 1;
                        state <= DETECT_SEQUENCE;
                    end
                end
                SHIFT_IN: begin
                    shift_data <= {shift_data[2:0], data};
                    state <= WAIT_COUNT;
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
                WAIT_COUNT: begin
                    if (done_counting) begin
                        done <= 1;
                        state <= IDLE;
                        shift_ena <= 0;
                        counting <= 0;
                    end else begin
                        done <= 0;
                        state <= WAIT_COUNT;
                        shift_ena <= 0;
                        counting <= 1;
                    end
                end
            endcase
        end
    end

endmodule
