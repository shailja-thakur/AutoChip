module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [2:0] state;
    reg [3:0] count;
    reg [3:0] shift_data;

    parameter IDLE = 3'b000;
    parameter DETECT_SEQUENCE = 3'b001;
    parameter SHIFT_IN = 3'b010;
    parameter WAIT_COUNT = 3'b011;

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
                        count <= 4'b0000;
                    end else begin
                        state <= IDLE;
                        count <= 4'b0000;
                        shift_ena <= 0;
                        counting <= 0;
                    end
                end
                DETECT_SEQUENCE: begin
                    shift_ena <= 1;
                    state <= SHIFT_IN;
                end
                SHIFT_IN: begin
                    if (count == 4'b0100) begin
                        shift_ena <= 0;
                        state <= WAIT_COUNT;
                    end else begin
                        count <= count + 1;
                        shift_ena <= 1;
                        state <= SHIFT_IN;
                    end
                end
                WAIT_COUNT: begin
                    counting <= 1;
                    if (done_counting) begin
                        done <= 1;
                        state <= IDLE;
                    end else begin
                        counting <= 0;
                        done <= 0;
                        state <= WAIT_COUNT;
                    end
                end
                default: begin
                    state <= IDLE;
                    count <= 4'b0000;
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
            endcase
        end
    end

endmodule
