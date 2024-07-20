module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
    );

    // Define states
    parameter IDLE = 2'b00;
    parameter SHIFT_ENA = 2'b01;
    parameter WAIT_DONE = 2'b10;
    parameter NOTIFICATION = 2'b11;

    // Define current state
    reg [1:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end
        else begin
            case(state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        shift_ena <= 1;
                        state <= SHIFT_ENA;
                    end
                end
                SHIFT_ENA: begin
                    if (shift_ena_count == 4) begin
                        counting <= 1;
                        shift_ena <= 0;
                        state <= WAIT_DONE;
                    end
                    else begin
                        shift_ena <= 1;
                        shift_ena_count <= shift_ena_count + 1;
                    end
                end
                WAIT_DONE: begin
                    if (done_counting) begin
                        done <= 1;
                        state <= NOTIFICATION;
                    end
                end
                NOTIFICATION: begin
                    if (ack) begin
                        done <= 0;
                        state <= IDLE;
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end

endmodule
