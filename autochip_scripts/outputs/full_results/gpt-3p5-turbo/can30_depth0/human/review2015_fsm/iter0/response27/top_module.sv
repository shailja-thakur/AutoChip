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
    reg [2:0] state;
    parameter IDLE = 3'b000;
    parameter DETECTING = 3'b001;
    parameter SHIFT_ENA = 3'b010;
    parameter WAITING = 3'b011;
    parameter TIMEOUT = 3'b100;
    
    always @(posedge clk) begin
        if (reset) begin
            // Reset to idle state when reset signal is high
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case(state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= DETECTING;
                    end else begin
                        state <= IDLE;
                    end
                end
                DETECTING: begin
                    state <= SHIFT_ENA;
                end
                SHIFT_ENA: begin
                    state <= WAITING;
                    shift_ena <= 1;
                end
                WAITING: begin
                    if (done_counting) begin
                        state <= TIMEOUT;
                    end else begin
                        state <= WAITING;
                    end
                    counting <= 1;
                end
                TIMEOUT: begin
                    if (ack) begin
                        state <= IDLE;
                        done <= 1;
                    end else begin
                        state <= TIMEOUT;
                    end
                    shift_ena <= 0;
                    counting <= 0;
                end
            endcase
        end
    end
endmodule
