module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define states for the finite-state machine
    parameter IDLE = 2'b00;
    parameter SEARCH = 2'b01;
    parameter COUNT = 2'b10;

    reg [1:0] state; // State register

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE; // Reset the state to IDLE
            shift_ena <= 0; // Reset shift_ena to 0
            counting <= 0; // Reset counting to 0
            done <= 0; // Reset done to 0
        end else begin
            case (state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        shift_ena <= 1;
                        state <= SEARCH;
                    end else begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                    end
                end

                SEARCH: begin
                    shift_ena <= 0;
                    if (data == 4'b1101) begin
                        state <= COUNT;
                    end else begin
                        state <= IDLE;
                    end
                end

                COUNT: begin
                    shift_ena <= 0;
                    counting <= 1;
                    if (done_counting) begin
                        done <= 1;
                        state <= IDLE;
                    end else begin
                        done <= 0;
                        state <= COUNT;
                    end
                end
                
                default: state <= IDLE;
            endcase
        end
    end

endmodule
