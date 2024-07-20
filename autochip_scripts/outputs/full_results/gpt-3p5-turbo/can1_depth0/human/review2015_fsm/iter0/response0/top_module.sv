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
    
    // state definitions
    parameter IDLE = 2'b00;
    parameter DETECT_PATTERN = 2'b01;
    parameter SHIFT_ENABLE = 2'b10;
    parameter WAIT_COUNTING = 2'b11;
    
    // state registers
    reg [3:0] next_state;
    reg [3:0] curr_state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    always @(state, data, done_counting, ack) begin
        // default next state
        next_state = state;
        
        case(state)
            
            IDLE: begin
                if (data == 4'b1101) begin
                    next_state = DETECT_PATTERN;
                end
            end
            
            DETECT_PATTERN: begin
                shift_ena <= 1'b1;
                counting <= 1'b0;
                next_state = SHIFT_ENABLE;
            end
            
            SHIFT_ENABLE: begin
                shift_ena <= 1'b0;
                counting <= 1'b1;
                next_state = WAIT_COUNTING;
            end
            
            WAIT_COUNTING: begin
                shift_ena <= 1'b0;
                counting <= 1'b1;
                if (done_counting) begin
                    done <= 1'b1;
                    next_state = IDLE;
                end
            end
            
        endcase
    end
    
    // reset to initial state
    always @(posedge clk) begin
        if (reset) begin
            done <= 1'b0;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            curr_state <= IDLE;
        end else begin
            curr_state <= state;
        end
    end
    
endmodule
