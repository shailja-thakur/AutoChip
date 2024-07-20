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

    // State declarations
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        PATTERN_DETECT = 3'b001,
        SHIFT = 3'b010,
        COUNT = 3'b011,
        NOTIFY = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [3:0] pattern_shift;
    reg [1:0] shift_count;
    
    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            pattern_shift <= 4'd0;
            shift_count <= 2'd0;
        end else begin
            state <= next_state;
            if (state == PATTERN_DETECT) begin
                pattern_shift <= {pattern_shift[2:0], data};
            end else if (state == SHIFT && shift_ena) begin
                shift_count <= shift_count + 1;
            end else if (state != SHIFT) begin
                shift_count <= 2'd0;
            end
        end
    end
    
    // Combinational logic for next state and output signals
    always @(*) begin
        // Default values
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        
        case (state)
            IDLE: begin
                if (pattern_shift == 4'b1101) begin
                    next_state = PATTERN_DETECT;
                end
            end
            
            PATTERN_DETECT: begin
                pattern_shift <= {pattern_shift[2:0], data};
                if (pattern_shift == 4'b1101) begin
                    next_state = SHIFT;
                end else if (pattern_shift[3:1] == 3'b110) begin
                    next_state = PATTERN_DETECT;
                end else begin
                    next_state = IDLE;
                end
            end
            
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_count == 3) begin
                    next_state = COUNT;
                end
            end
            
            COUNT: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = NOTIFY;
                end
            end
            
            NOTIFY: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                    pattern_shift <= 4'd0;
                    shift_count <= 2'd0;
                end
            end
            
            default: next_state = IDLE;
        endcase
    end
endmodule
