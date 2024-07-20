module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'd0,
        CHECK_PATTERN = 3'd1,
        LOAD_DELAY = 3'd2,
        COUNTING = 3'd3,
        DONE = 3'd4
    } state_t;
    
    state_t state, next_state;
    reg [3:0] delay, next_delay;
    reg [15:0] cycle_count, next_cycle_count;
    reg [3:0] shift_reg, next_shift_reg;
    reg [1:0] bit_count, next_bit_count; // Counter to track the number of bits shifted for pattern and delay
    
    // State Machine Combinatorial Logic
    always @(*) begin
        next_state = state;
        next_delay = delay;
        next_cycle_count = cycle_count;
        next_shift_reg = shift_reg;
        next_bit_count = bit_count;
        
        case(state)
            IDLE: begin
                counting = 0;
                done = 0;
                count = 4'd0;
                if (reset) begin
                    next_state = CHECK_PATTERN;
                    next_shift_reg = 4'd0;
                    next_bit_count = 2'd0;
                end
            end
            CHECK_PATTERN: begin
                count = 4'd0;
                done = 0;
                if (bit_count == 2'd4) begin
                    if (shift_reg == 4'b1101) begin
                        next_state = LOAD_DELAY;
                        next_shift_reg = 4'd0;
                        next_bit_count = 2'd0;
                    end else begin
                        next_state = CHECK_PATTERN;
                        next_shift_reg = {shift_reg[2:0], data};
                        next_bit_count = bit_count + 1;
                    end
                end else begin
                    next_shift_reg = {shift_reg[2:0], data};
                    next_bit_count = bit_count + 1;
                end
            end
            LOAD_DELAY: begin
                done = 0;
                count = 4'd0;
                if (bit_count == 2'd4) begin
                    next_delay = shift_reg;
                    next_cycle_count = 16'd0;
                    next_state = COUNTING;
                end else begin
                    next_shift_reg = {shift_reg[2:0], data};
                    next_bit_count = bit_count + 1;
                end
            end
            COUNTING: begin
                counting = 1;
                done = 0;
                count = delay - (cycle_count / 1000);
                if (cycle_count == (delay + 1) * 1000 - 1) begin
                    next_state = DONE;
                end else begin
                    next_cycle_count = cycle_count + 1;
                end
            end
            DONE: begin
                counting = 0;
                count = 4'd0;
                done = 1;
                if (ack) begin
                    next_state = CHECK_PATTERN;
                    next_shift_reg = 4'd0;
                    next_bit_count = 2'd0;
                end
            end
            default: next_state = IDLE;
        endcase
    end
    
    // State Machine Sequential Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            delay <= 4'd0;
            cycle_count <= 16'd0;
            shift_reg <= 4'd0;
            bit_count <= 2'd0;
        end else begin
            state <= next_state;
            delay <= next_delay;
            cycle_count <= next_cycle_count;
            shift_reg <= next_shift_reg;
            bit_count <= next_bit_count;
        end
    end
endmodule
