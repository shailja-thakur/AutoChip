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
    reg [3:0] shift_counter;
    
    parameter IDLE = 0;
    parameter DETECT = 1;
    parameter SHIFT = 2;
    parameter COUNT = 3;
    parameter NOTIFY = 4;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    always @* begin
        next_state = state;
        shift_ena = 0;
        counting = 0;
        done = 0;

        case(state)
            IDLE: begin
                if (data == 4'b1101) begin
                    next_state = DETECT;
                    shift_counter = 0;
                end
            end
            
            DETECT: begin
                if (data == 4'b1101) begin
                    shift_counter = 0;
                    next_state = DETECT;
                end else begin
                    shift_counter = 0;
                    next_state = IDLE;
                end
            end
            
            SHIFT: begin
                shift_ena = 1;
                shift_counter = shift_counter + 1;
                
                if (shift_counter == 4) begin
                    shift_ena = 0;
                    shift_counter = 0;
                    counting = 1;
                    next_state = COUNT;
                end
            end
            
            COUNT: begin
                counting = 1;
                
                if (done_counting) begin
                    counting = 0;
                    done = 1;
                    next_state = NOTIFY;
                end
            end
            
            NOTIFY: begin
                done = 1;
                
                if (ack) begin
                    done = 0;
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule
