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
    typedef enum logic [2:0] {
        WAIT_PATTERN = 3'b000,
        SHIFT_BITS   = 3'b001,
        WAIT_COUNTER = 3'b010,
        NOTIFY       = 3'b011,
        WAIT_ACK     = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [2:0] pattern_shift_reg;
    reg [1:0] shift_count;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            WAIT_PATTERN: begin
                if (pattern_shift_reg == 3'b110 && data == 1) 
                    next_state = SHIFT_BITS;
                else 
                    next_state = WAIT_PATTERN;
            end
            SHIFT_BITS: begin
                if (shift_count == 2'd3)
                    next_state = WAIT_COUNTER;
                else
                    next_state = SHIFT_BITS;
            end
            WAIT_COUNTER: begin
                if (done_counting) 
                    next_state = NOTIFY;
                else 
                    next_state = WAIT_COUNTER;
            end
            NOTIFY: begin
                if (ack) 
                    next_state = WAIT_PATTERN;
                else 
                    next_state = WAIT_ACK;
            end
            WAIT_ACK: begin
                if (ack) 
                    next_state = WAIT_PATTERN;
                else 
                    next_state = WAIT_ACK;
            end
            default: next_state = WAIT_PATTERN;
        endcase
    end

    // Output logic and state register update (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_PATTERN;
            pattern_shift_reg <= 3'b000;
            shift_count <= 2'd0;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end
        else begin
            state <= next_state;
            // Pattern detection logic
            if (state == WAIT_PATTERN) begin
                pattern_shift_reg <= {pattern_shift_reg[1:0], data};
            end

            // Shift enable logic
            if (state == SHIFT_BITS) begin
                shift_ena <= 1;
                shift_count <= shift_count + 1;
            end
            else begin
                shift_ena <= 0;
                shift_count <= 0;
            end

            // Counting logic
            if (state == WAIT_COUNTER) 
                counting <= 1;
            else 
                counting <= 0;

            // Done signal logic
            if (state == NOTIFY || state == WAIT_ACK) 
                done <= 1;
            else 
                done <= 0;
        end
    end

endmodule
