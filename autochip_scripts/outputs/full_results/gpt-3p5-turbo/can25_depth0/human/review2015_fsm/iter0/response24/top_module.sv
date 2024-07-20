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
    
    // Define the states
    parameter IDLE = 4'b0000;
    parameter DETECT_PATTERN = 4'b0001;
    parameter SHIFT_IN = 4'b0010;
    parameter WAITING_FOR_COUNTERS = 4'b0011;
    parameter TIMER_DONE = 4'b0100;
    
    // Initialize the state machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Define the next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (data == 4'b1101) begin
                    next_state = DETECT_PATTERN;
                end else begin
                    next_state = IDLE;
                end
            end
            
            DETECT_PATTERN: begin
                next_state = SHIFT_IN;
            end
            
            SHIFT_IN: begin
                if (shift_ena) begin
                    next_state = WAITING_FOR_COUNTERS;
                end else begin
                    next_state = SHIFT_IN;
                end
            end
            
            WAITING_FOR_COUNTERS: begin
                if (done_counting) begin
                    next_state = TIMER_DONE;
                end else begin
                    next_state = WAITING_FOR_COUNTERS;
                end
            end
            
            TIMER_DONE: begin
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = TIMER_DONE;
                end
            end
        endcase
    end
    
    // Output logic
    always @(posedge clk) begin
        case (state)
            IDLE: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            
            DETECT_PATTERN: begin
                shift_ena <= 1;
                counting <= 0;
                done <= 0;
            end
            
            SHIFT_IN: begin
                shift_ena <= 1;
                counting <= 0;
                done <= 0;
            end
            
            WAITING_FOR_COUNTERS: begin
                shift_ena <= 0;
                counting <= 1;
                done <= 0;
            end
            
            TIMER_DONE: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
            end
        endcase
    end
endmodule
