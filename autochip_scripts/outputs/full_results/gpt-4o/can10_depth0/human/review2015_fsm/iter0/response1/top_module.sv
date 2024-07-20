module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack);

    // State encoding
    typedef enum logic [2:0] {
        WAIT_PATTERN = 3'b000,
        SHIFT_4_BITS = 3'b001,
        WAIT_COUNT   = 3'b010,
        DONE_STATE   = 3'b011
    } state_t;
    
    state_t state, next_state;
    reg [3:0] shift_count;
    reg [3:0] pattern_shift;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= WAIT_PATTERN;
            shift_count <= 4'b0000;
            pattern_shift <= 4'b0000;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        
        case (state)
            WAIT_PATTERN: begin
                // Shift in the data into pattern_shift register
                pattern_shift = {pattern_shift[2:0], data};
                if (pattern_shift == 4'b1101) begin
                    next_state = SHIFT_4_BITS;
                    shift_count = 4'b0000;
                end
            end
            
            SHIFT_4_BITS: begin
                shift_ena = 1'b1;
                shift_count = shift_count + 1;
                if (shift_count == 4'b0011) begin
                    next_state = WAIT_COUNT;
                end
            end
            
            WAIT_COUNT: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = DONE_STATE;
                end
            end
            
            DONE_STATE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = WAIT_PATTERN;
                end
            end
        endcase
    end

endmodule
