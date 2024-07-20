module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State declaration
    typedef enum logic [2:0] {
        S_IDLE,
        S_PATTERN_DETECT,
        S_SHIFT,
        S_COUNT,
        S_DONE,
        S_WAIT_ACK
    } state_t;

    state_t state, next_state;
    reg [3:0] shift_count;
    reg [3:0] pattern_shift_reg;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state; // Default to hold current state
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case(state)
            S_IDLE: begin
                if (pattern_shift_reg == 4'b1101) begin
                    next_state = S_SHIFT;
                end else begin
                    next_state = S_PATTERN_DETECT;
                end
            end

            S_PATTERN_DETECT: begin
                pattern_shift_reg = {pattern_shift_reg[2:0], data};
                if (pattern_shift_reg == 4'b1101) begin
                    next_state = S_SHIFT;
                end
            end

            S_SHIFT: begin
                shift_ena = 1'b1;
                if (shift_count == 4) begin
                    next_state = S_COUNT;
                end
            end

            S_COUNT: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = S_DONE;
                end
            end

            S_DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = S_IDLE;
                end else begin
                    next_state = S_WAIT_ACK;
                end
            end

            S_WAIT_ACK: begin
                done = 1'b1;
                if (ack) begin
                    next_state = S_IDLE;
                end
            end

            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    // Output and counter control logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_count <= 4'd0;
            pattern_shift_reg <= 4'd0;
        end else if (state == S_SHIFT && shift_ena) begin
            if (shift_count < 4) begin
                shift_count <= shift_count + 1;
            end else begin
                shift_count <= 4'd0;
            end
        end else if (state == S_PATTERN_DETECT) begin
            pattern_shift_reg <= {pattern_shift_reg[2:0], data};
        end else if (state != S_SHIFT) begin
            shift_count <= 4'd0;
        end
    end
endmodule
