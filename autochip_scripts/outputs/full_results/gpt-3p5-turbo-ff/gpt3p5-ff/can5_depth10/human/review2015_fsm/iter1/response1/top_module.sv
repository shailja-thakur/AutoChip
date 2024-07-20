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
    reg [2:0] count;
    
    reg [3:0] next_state;
    reg [2:0] next_count;
    
    parameter IDLE = 2'b00;
    parameter DETECT_SEQUENCE = 2'b01;
    parameter SHIFT_IN = 2'b10;
    parameter WAIT_COUNT = 2'b11;

    always@(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            count <= next_count;
        end
    end
    
    always@(*) begin
        next_state = state;
        next_count = count;
        
        case(state)
            IDLE: begin
                if (data == 4'b1101) begin
                    next_state = DETECT_SEQUENCE;
                    next_count = count + 1;
                end
            end
            
            DETECT_SEQUENCE: begin
                if (count == 3) begin
                    next_state = SHIFT_IN;
                    next_count = 0;
                end else begin
                    next_count = count + 1;
                end
            end
            
            SHIFT_IN: begin
                next_state = WAIT_COUNT;
                next_count = count;
            end
            
            WAIT_COUNT: begin
                if (done_counting) begin
                    next_state = IDLE;
                    next_count = 0;
                end
            end
            
            default: begin
                next_state = IDLE;
                next_count = 0;
            end
        endcase
    end
    
    always@(state) begin
        shift_ena = 0;
        counting = 0;
        done = 0;
        
        case(state)
            DETECT_SEQUENCE: begin
                if (count < 4) begin
                    shift_ena = 1;
                end
            end
            
            WAIT_COUNT: begin
                counting = 1;
                
                if (done_counting) begin
                    done = 1;
                end
            end
        endcase
    end
    
endmodule
