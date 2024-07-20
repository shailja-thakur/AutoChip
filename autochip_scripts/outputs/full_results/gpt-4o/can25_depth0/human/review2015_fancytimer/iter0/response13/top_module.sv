module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);
    // State encoding
    typedef enum reg [2:0] {
        WAIT_PATTERN  = 3'd0,
        READ_DELAY    = 3'd1,
        COUNT         = 3'd2,
        WAIT_ACK      = 3'd3
    } state_t;

    state_t state, next_state;

    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [11:0] cycle_count; // Counting up to (delay + 1) * 1000 cycles
    reg pattern_detected;
    
    // State Machine
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_PATTERN;
            shift_reg <= 4'b0;
            delay <= 4'b0;
            cycle_count <= 12'b0;
            pattern_detected <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == WAIT_PATTERN && data) begin
                shift_reg <= {shift_reg[2:0], data}; // Shift in the data bit
                if (shift_reg == 4'b1101) begin
                    pattern_detected <= 1'b1;
                    count <= 4'b0;
                end
            end
            if (state == READ_DELAY) begin
                shift_reg <= {shift_reg[2:0], data}; // Shift in the data bit for delay
                delay <= shift_reg;
            end
            if (state == COUNT && counting) begin
                if (cycle_count == 12'd1000) begin
                    if (count > 0) begin
                        count <= count - 1;
                        cycle_count <= 12'd0;
                    end else begin
                        next_state <= WAIT_ACK;
                        counting <= 0;
                        done <= 1;
                    end
                end else begin
                    cycle_count <= cycle_count + 1;
                end
            end
            if (state == WAIT_ACK && ack) begin
                next_state <= WAIT_PATTERN;
                pattern_detected <= 0;
                done <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            WAIT_PATTERN: begin
                if (pattern_detected) next_state = READ_DELAY;
            end
            READ_DELAY: begin
                next_state = COUNT;
                counting = 1;
                count = delay;
            end
            COUNT: begin
                if (count == 0) begin
                    next_state = WAIT_ACK;
                    counting = 0;
                    done = 1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    next_state = WAIT_PATTERN;
                    done = 0;
                end
            end
        endcase
    end
    
endmodule
