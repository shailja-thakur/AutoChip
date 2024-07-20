module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [3:0] state, next_state;
    reg [3:0] pattern;
    
    // State encoding
    localparam IDLE = 4'b0000,
               PATTERN_MATCHED = 4'b0001,
               SHIFT_DATA = 4'b0010,
               WAIT_COUNT = 4'b0011,
               DONE_WAIT_ACK = 4'b0100,
               RESET_STATE = 4'b0101;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            pattern <= 4'b0000;
        end else begin
            state <= next_state;
            if (state == IDLE || state == RESET_STATE) begin
                pattern <= {pattern[2:0], data};
            end
        end
    end

    always @(*) begin
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            IDLE: begin
                if (pattern == 4'b1101)
                    next_state = PATTERN_MATCHED;
                else
                    next_state = IDLE;
            end
            
            PATTERN_MATCHED: begin
                next_state = SHIFT_DATA;
            end
            
            SHIFT_DATA: begin
                shift_ena = 1;
                if (pattern == 4'b1111) // After 4 cycles, pattern will be 4 bit long.
                    next_state = WAIT_COUNT;
                else
                    next_state = SHIFT_DATA;
            end
            
            WAIT_COUNT: begin
                counting = 1;
                if (done_counting)
                    next_state = DONE_WAIT_ACK;
                else
                    next_state = WAIT_COUNT;
            end
            
            DONE_WAIT_ACK: begin
                done = 1;
                if (ack)
                    next_state = RESET_STATE;
                else
                    next_state = DONE_WAIT_ACK;
            end
            
            RESET_STATE: begin
                next_state = IDLE;
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
