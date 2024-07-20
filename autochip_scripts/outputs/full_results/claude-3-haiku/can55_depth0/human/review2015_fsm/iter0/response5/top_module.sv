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

    parameter WAIT_FOR_START = 0;
    parameter SHIFT_DURATION = 1;
    parameter WAIT_FOR_TIMER = 2;
    parameter TIMER_DONE = 3;
    
    reg [1:0] state, next_state;
    reg [3:0] shift_count;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_FOR_START;
            shift_count <= 0;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end
        else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        next_state = state;
        shift_ena = 0;
        counting = 0;
        done = 0;
        case (state)
            WAIT_FOR_START: begin
                if (data == 1'b1) begin
                    if ({data, data, data, data} == 4'b1101) begin
                        next_state = SHIFT_DURATION;
                        shift_ena = 1;
                        shift_count = 0;
                    end
                end
            end
            SHIFT_DURATION: begin
                shift_ena = 1;
                shift_count = shift_count + 1;
                if (shift_count == 4) begin
                    next_state = WAIT_FOR_TIMER;
                    counting = 1;
                end
            end
            WAIT_FOR_TIMER: begin
                if (done_counting) begin
                    next_state = TIMER_DONE;
                    done = 1;
                end
            end
            TIMER_DONE: begin
                if (ack) begin
                    next_state = WAIT_FOR_START;
                end
            end
        endcase
    end
    
endmodule
