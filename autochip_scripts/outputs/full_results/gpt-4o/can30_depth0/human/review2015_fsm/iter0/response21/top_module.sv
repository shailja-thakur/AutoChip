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
    
    typedef enum logic[2:0] {
        IDLE = 3'b000,
        PATTERN_1 = 3'b001,
        PATTERN_11 = 3'b010,
        PATTERN_110 = 3'b011,
        PATTERN_1101 = 3'b100,
        SHIFT = 3'b101,
        COUNT = 3'b110,
        DONE = 3'b111
    } state_t;
    
    state_t state, next_state;
    reg [2:0] shift_count; // to count 4 clock cycles for shift_ena

    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            state <= IDLE;
        else 
            state <= next_state;
    end

    always_ff @(posedge clk) begin
        if (state == SHIFT)
            shift_count <= shift_count + 1;
        else
            shift_count <= 3'd0;
    end

    always_comb begin
        case (state)
            IDLE: begin
                shift_ena = 0;
                counting = 0;
                done = 0;
                if (data == 1'b1) 
                    next_state = PATTERN_1;
                else 
                    next_state = IDLE;
            end
            PATTERN_1: begin
                shift_ena = 0;
                counting = 0;
                done = 0;
                if (data == 1'b1)
                    next_state = PATTERN_11;
                else
                    next_state = IDLE;
            end
            PATTERN_11: begin
                shift_ena = 0;
                counting = 0;
                done = 0;
                if (data == 1'b0)
                    next_state = PATTERN_110;
                else
                    next_state = IDLE;
            end
            PATTERN_110: begin
                shift_ena = 0;
                counting = 0;
                done = 0;
                if (data == 1'b1)
                    next_state = PATTERN_1101;
                else
                    next_state = IDLE;
            end
            PATTERN_1101: begin
                shift_ena = 1;
                counting = 0;
                done = 0;
                next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1;
                counting = 0;
                done = 0;
                if (shift_count == 3) begin
                    next_state = COUNT;
                    shift_ena = 0;
                end
                else
                    next_state = SHIFT;
            end
            COUNT: begin
                shift_ena = 0;
                counting = 1;
                done = 0;
                if (done_counting)
                    next_state = DONE;
                else 
                    next_state = COUNT;
            end
            DONE: begin
                shift_ena = 0;
                counting = 0;
                done = 1;
                if (ack)
                    next_state = IDLE;
                else 
                    next_state = DONE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
