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
    typedef enum reg [2:0] {
        IDLE        = 3'b000,
        PAT_DETECT  = 3'b001,
        SHIFT       = 3'b010,
        COUNT       = 3'b011,
        DONE        = 3'b100,
        WAIT_ACK    = 3'b101
    } state_t;

    state_t state, next_state;

    // Pattern detection shift register
    reg [3:0] pattern_shift;
    wire pattern_found = (pattern_shift == 4'b1101);

    // Sequential state transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (data) // Assume data is bit to be shifted into pattern_shift register
                    next_state = PAT_DETECT;
                else
                    next_state = IDLE;
            end

            PAT_DETECT: begin
                if (pattern_found)
                    next_state = SHIFT;
                else
                    next_state = IDLE;
            end

            SHIFT: begin
                if (shift_count == 4)
                    next_state = COUNT;
                else
                    next_state = SHIFT;
            end

            COUNT: begin
                if (done_counting)
                    next_state = DONE;
                else
                    next_state = COUNT;
            end

            DONE: begin
                if (ack)
                    next_state = IDLE;
                else
                    next_state = WAIT_ACK;
            end

            WAIT_ACK: begin
                if (ack)
                    next_state = IDLE;
                else
                    next_state = WAIT_ACK;
            end

            default: next_state = IDLE;
        endcase
    end

    // Update pattern shift register and shift count
    reg [2:0] shift_count;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pattern_shift <= 4'b0;
            shift_count <= 0;
        end else if (state == PAT_DETECT) begin
            pattern_shift <= {pattern_shift[2:0], data};
        end else if (state == SHIFT) begin
            shift_count <= shift_count + 1;
        end else begin
            pattern_shift <= 4'b0;
            shift_count <= 0;
        end
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                SHIFT: begin
                    shift_ena <= 1;
                    counting <= 0;
                    done <= 0;
                end

                COUNT: begin
                    shift_ena <= 0;
                    counting <= 1;
                    done <= 0;
                end

                DONE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 1;
                end

                WAIT_ACK: begin
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
