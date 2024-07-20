module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack);
    
    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'd0,
        DETECT_PATTERN = 3'd1,
        SHIFT_DELAY = 3'd2,
        COUNT = 3'd3,
        DONE = 3'd4
    } state_t;

    state_t curr_state, next_state;
    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [13:0] cycle_count;

    // Sequential: State Register
    always @(posedge clk) begin
        if (reset)
            curr_state <= IDLE;
        else
            curr_state <= next_state;
    end

    // Combinational: Next State Logic and Output Logic
    always @(*) begin
        count = 4'bxxxx; // Don't care
        counting = 1'b0;
        done = 1'b0;
        next_state = curr_state;
        case (curr_state)
            IDLE: begin
                if (reset)
                    next_state = DETECT_PATTERN;
            end

            DETECT_PATTERN: begin
                if (shift_reg == 4'b1101)
                    next_state = SHIFT_DELAY;
            end

            SHIFT_DELAY: begin
                if (cycle_count == 14'd15) // After 4 more shifts (data valid for delay)
                    next_state = COUNT;
            end

            COUNT: begin
                counting = 1'b1;
                count = delay - (cycle_count / 1000);
                if (cycle_count == (delay + 1) * 1000 - 1)
                    next_state = DONE;
            end

            DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = DETECT_PATTERN;
            end

            default: next_state = IDLE;
        endcase
    end

    // Sequential: Shift Register and Cycle Counter
    always @(posedge clk) begin
        if (reset || curr_state != next_state)
            shift_reg <= 4'b0000;
        else if (curr_state == DETECT_PATTERN || curr_state == SHIFT_DELAY)
            shift_reg <= {shift_reg[2:0], data};

        if (reset || curr_state != next_state)
            cycle_count <= 14'd0;
        else if (curr_state == COUNT || curr_state == SHIFT_DELAY)
            cycle_count <= cycle_count + 1;
    end

    // Sequential: Delay Register
    always @(posedge clk) begin
        if (reset)
            delay <= 4'd0;
        else if (curr_state == SHIFT_DELAY && cycle_count == 14'd15)
            delay <= shift_reg;
    end

endmodule
