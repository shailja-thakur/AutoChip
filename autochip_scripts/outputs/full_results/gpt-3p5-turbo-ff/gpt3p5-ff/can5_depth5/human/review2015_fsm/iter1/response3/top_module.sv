module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    parameter WAIT_FOR_START = 2'b00;
    parameter SHIFT_ENABLE = 2'b01;
    parameter WAIT_FOR_DONE = 2'b10;
    parameter DONE_AND_WAIT = 2'b11;
    
    reg [1:0] state;
    reg [3:0] count;
    reg start_detected;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_FOR_START;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            count <= 0;
            start_detected <= 0;
        end else begin
            case (state)
                WAIT_FOR_START: begin
                    if (data == 4'b1101) begin
                        start_detected <= 1;
                        state <= SHIFT_ENABLE;
                        shift_ena <= 1;
                        count <= 0;
                    else
                        state <= WAIT_FOR_START;
                    end
                end
                
                SHIFT_ENABLE: begin
                    shift_ena <= 0;
                    count <= data;
                    state <= WAIT_FOR_DONE;
                    counting <= 1;
                end
                
                WAIT_FOR_DONE: begin
                    if (done_counting)
                        state <= DONE_AND_WAIT;
                    else
                        state <= WAIT_FOR_DONE;
                end
                
                DONE_AND_WAIT: begin
                    if (ack) begin
                        done <= 0;
                        state <= WAIT_FOR_START;
                        start_detected <= 0;
                    else
                        state <= DONE_AND_WAIT;
                    end
                end
            endcase
        end
    end

endmodule
