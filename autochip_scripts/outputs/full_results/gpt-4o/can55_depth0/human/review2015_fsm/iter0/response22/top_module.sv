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

    // State encoding
    localparam IDLE = 3'd0,
               S1 = 3'd1,
               S2 = 3'd2,
               S3 = 3'd3,
               PATTERN_DETECTED = 3'd4,
               SHIFT = 3'd5,
               COUNT = 3'd6,
               DONE = 3'd7;

    reg [2:0] state, next_state;
    reg [2:0] shift_counter;

    // State transition logic
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and outputs
    always @ (*) begin
        // Default outputs
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            IDLE: begin
                if (data == 1)
                    next_state = S1;
                else
                    next_state = IDLE;
            end
            S1: begin
                if (data == 1)
                    next_state = S2;
                else
                    next_state = IDLE;
            end
            S2: begin
                if (data == 0)
                    next_state = S3;
                else
                    next_state = IDLE;
            end
            S3: begin
                if (data == 1)
                    next_state = PATTERN_DETECTED;
                else
                    next_state = IDLE;
            end
            PATTERN_DETECTED: begin
                shift_ena = 1;
                next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 3'd3)
                    next_state = COUNT;
                else
                    next_state = SHIFT;
            end
            COUNT: begin
                counting = 1;
                if (done_counting)
                    next_state = DONE;
                else
                    next_state = COUNT;
            end
            DONE: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
                else
                    next_state = DONE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Shift counter logic
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            shift_counter <= 3'd0;
        end else if (state == SHIFT) begin
            if (shift_counter != 3'd3)
                shift_counter <= shift_counter + 1;
        end else begin
            shift_counter <= 3'd0;
        end
    end

endmodule
