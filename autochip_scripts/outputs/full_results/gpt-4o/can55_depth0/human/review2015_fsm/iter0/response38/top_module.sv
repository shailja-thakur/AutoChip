module top_module (
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

    // Define state encoding
    typedef enum logic [3:0] {
        IDLE = 4'd0,
        S1 = 4'd1,
        S2 = 4'd2,
        S3 = 4'd3,
        PATTERN_DETECTED = 4'd4,
        SHIFT = 4'd5,
        WAIT_COUNT = 4'd6,
        DONE = 4'd7
    } state_t;

    state_t state, next_state;
    reg [1:0] shift_counter; // Counter for the 4 bits shift

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Counter update logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            shift_counter <= 2'd0;
        else if (state == SHIFT)
            shift_counter <= shift_counter + 1;
        else
            shift_counter <= 2'd0;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data) next_state = S1;
            end
            S1: begin
                if (data) next_state = S2;
                else next_state = IDLE;
            end
            S2: begin
                if (~data) next_state = S3;
                else next_state = IDLE;
            end
            S3: begin
                if (data) next_state = PATTERN_DETECTED;
                else next_state = IDLE;
            end
            PATTERN_DETECTED: begin
                if (shift_counter == 2'd3) 
                    next_state = SHIFT;
                else
                    next_state = PATTERN_DETECTED;
            end
            SHIFT: begin
                if (shift_counter == 2'd3)
                    next_state = WAIT_COUNT;
                else
                    next_state = SHIFT;
            end
            WAIT_COUNT: begin
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                if (ack)
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
                S1, S2, S3, PATTERN_DETECTED: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
                SHIFT: begin
                    shift_ena <= 1;
                    counting <= 0;
                    done <= 0;
                end
                WAIT_COUNT: begin
                    shift_ena <= 0;
                    counting <= 1;
                    done <= 0;
                end
                DONE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 1;
                end
                default: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
            endcase
        end
    end

endmodule
