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
    parameter DETECTING = 4'b0001;
    parameter SHIFTING = 4'b0010;
    parameter WAITING = 4'b0011;
    parameter TIMEOUT = 4'b0100;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    always @* begin
        shift_ena = 0;
        counting = 0;
        done = 0;
        next_state = IDLE;
        
        case (state)
            IDLE:
                if (data == 4'b1101) begin
                    shift_ena = 1;
                    next_state = DETECTING;
                end
            DETECTING:
                if (shift_ena && done_counting) begin
                    counting = 1;
                    next_state = WAITING;
                end
            SHIFTING:
                if (counting && done_counting) begin
                    counting = 0;
                    next_state = TIMEOUT;
                end
            WAITING:
                if (done_counting) begin
                    done = 1;
                    next_state = IDLE;
                end
            TIMEOUT:
                if (ack) begin
                    next_state = IDLE;
                end
        endcase
    end
endmodule
