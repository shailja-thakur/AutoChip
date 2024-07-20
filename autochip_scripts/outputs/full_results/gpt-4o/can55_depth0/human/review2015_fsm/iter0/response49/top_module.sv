module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State definitions
    typedef enum reg [3:0] {
        IDLE        = 4'b0000,
        DETECT_1    = 4'b0001,
        DETECT_11   = 4'b0010,
        DETECT_110  = 4'b0011,
        DETECT_1101 = 4'b0100,
        SHIFTING    = 4'b0101,
        COUNTING    = 4'b0110,
        DONE        = 4'b0111
    } state_t;

    state_t state, next_state;
    reg [1:0] shift_counter;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 2'd0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        // Default output values
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        next_state = state;

        case(state)
            IDLE: begin
                if (data == 1'b1)
                    next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data == 1'b1)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end
            DETECT_11: begin
                if (data == 1'b0)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end
            DETECT_110: begin
                if (data == 1'b1)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end
            DETECT_1101: begin
                next_state = SHIFTING;
            end
            SHIFTING: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'd3)
                    next_state = COUNTING;
                end
            COUNTING: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Shift counter increment
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_counter <= 2'd0;
        end else if (state == SHIFTING) begin
            shift_counter <= shift_counter + 1'b1;
        end else begin
            shift_counter <= 2'd0;
        end
    end

endmodule
