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
    parameter SHIFT_ENA = 4'b0001;
    parameter COUNTING = 4'b0010;
    parameter DONE = 4'b0011;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    always @* begin
        next_state = state;
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = SHIFT_ENA;
                end
            end
            
            SHIFT_ENA: begin
                shift_ena = 1;
                next_state = COUNTING;
            end
            
            COUNTING: begin
                counting = 1;
                if (done_counting) begin
                    next_state = DONE;
                end
            end
            
            DONE: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end
    
endmodule
