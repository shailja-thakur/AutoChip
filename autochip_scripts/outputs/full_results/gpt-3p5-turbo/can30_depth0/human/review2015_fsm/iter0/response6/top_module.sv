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
    reg [3:0] next_state;
    
    parameter IDLE = 4'b0000;
    parameter DETECTED = 4'b0001;
    parameter SHIFTING = 4'b0010;
    parameter COUNTING = 4'b0011;
    parameter NOTIFIED = 4'b0100;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end
        else begin
            state <= next_state;
            case(state)
                IDLE: begin
                    if (data) begin
                        if (data == 4'b1101) begin
                            next_state = DETECTED;
                        end
                        else begin
                            next_state = IDLE;
                        end
                    end
                    else begin
                        next_state = IDLE;
                    end
                end
                
                DETECTED: begin
                    next_state = SHIFTING;
                    shift_ena = 1;
                end
                
                SHIFTING: begin
                    if (shift_ena && done_counting) begin
                        next_state = COUNTING;
                        counting = 1;
                    end
                    else begin
                        next_state = SHIFTING;
                    end
                end
                
                COUNTING: begin
                    if (done_counting) begin
                        next_state = NOTIFIED;
                        counting = 0;
                        done = 1;
                    end
                    else begin
                        next_state = COUNTING;
                    end
                end
                
                NOTIFIED: begin
                    if (ack) begin
                        next_state = IDLE;
                        done = 0;
                    end
                    else begin
                        next_state = NOTIFIED;
                    end
                end
            endcase
        end
    end

endmodule
