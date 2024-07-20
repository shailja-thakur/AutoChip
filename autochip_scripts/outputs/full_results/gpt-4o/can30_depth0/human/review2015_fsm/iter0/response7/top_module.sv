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

    typedef enum reg [2:0] {
        IDLE,
        PATTERN_DET_1,
        PATTERN_DET_11,
        PATTERN_DET_110,
        PATTERN_DET_1101,
        SHIFT_PHASE,
        COUNTING_PHASE,
        DONE_PHASE
    } state_t;
    
    state_t state, next_state;
    reg [2:0] shift_counter;
    
    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // State Transition Conditions
    always @(*) begin
        case (state)
            IDLE: next_state = data ? PATTERN_DET_1 : IDLE;
            PATTERN_DET_1: next_state = data ? PATTERN_DET_11 : IDLE;
            PATTERN_DET_11: next_state = data ? PATTERN_DET_11 : PATTERN_DET_110;
            PATTERN_DET_110: next_state = data ? PATTERN_DET_1101 : IDLE;
            PATTERN_DET_1101: next_state = SHIFT_PHASE;
            SHIFT_PHASE: next_state = (shift_counter == 3) ? COUNTING_PHASE : SHIFT_PHASE;
            COUNTING_PHASE: next_state = done_counting ? DONE_PHASE : COUNTING_PHASE;
            DONE_PHASE: next_state = ack ? IDLE : DONE_PHASE;
            default: next_state = IDLE;
        endcase
    end
    
    // Output Logic and Internal Registers Update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_counter <= 0;
        end else begin
            case (state)
                IDLE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
                PATTERN_DET_1: begin
                end
                PATTERN_DET_11: begin
                end
                PATTERN_DET_110: begin
                end
                PATTERN_DET_1101: begin
                end
                SHIFT_PHASE: begin
                    shift_ena <= 1;
                    shift_counter <= shift_counter + 1;
                    if (shift_counter == 3) begin
                        shift_ena <= 0;
                        shift_counter <= 0;
                    end
                end
                COUNTING_PHASE: begin
                    counting <= 1;
                end
                DONE_PHASE: begin
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
