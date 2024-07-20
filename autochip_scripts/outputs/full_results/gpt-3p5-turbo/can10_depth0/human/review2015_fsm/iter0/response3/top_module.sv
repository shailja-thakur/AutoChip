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

    parameter IDLE = 2'b00;
    parameter DETECT = 2'b01;
    parameter SHIFTIN = 2'b10;
    parameter WAIT = 2'b11;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        shift_ena <= 1;
                        counting <= 0;
                        state <= DETECT;
                    end else begin
                        shift_ena <= 0;
                        counting <= 0;
                        state <= IDLE;
                    end
                end
                DETECT: begin
                    shift_ena <= 1;
                    counting <= 0;
                    state <= SHIFTIN;
                end
                SHIFTIN: begin
                    shift_ena <= 1;
                    counting <= 0;
                    state <= WAIT;
                end
                WAIT: begin
                    shift_ena <= 0;
                    counting <= 1;

                    if (done_counting) begin
                        done <= 1;
                        state <= IDLE;
                    end else begin
                        done <= 0;
                        state <= WAIT;
                    end
                end
            endcase
        end
    end

endmodule
