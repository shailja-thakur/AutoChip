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
        IDLE,
        PATTERN_DETECT,
        SHIFT,
        COUNT,
        DONE
    } state_t;

    state_t state, next_state;
    
    // Pattern detection register (4-bit shift register)
    reg [3:0] pattern_detect;
    reg [2:0] shift_counter;
    
    // State Transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Next State Logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (pattern_detect == 4'b1101) begin
                    next_state = SHIFT;
                end else begin
                    next_state = PATTERN_DETECT;
                end
            end
            PATTERN_DETECT: begin
                if (pattern_detect == 4'b1101) begin
                    next_state = SHIFT;
                end
            end
            SHIFT: begin
                if (shift_counter == 3) begin
                    next_state = COUNT;
                end
            end
            COUNT: begin
                if (done_counting) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE; // Fallback state
        endcase
    end
    
    // Pattern Detect Shift Register and Shift Counter
    always @(posedge clk) begin
        if (reset) begin
            pattern_detect <= 4'b0;
            shift_counter <= 3'b000;
        end else begin
            case (state)
                IDLE: begin
                    pattern_detect <= 4'b0;
                end
                PATTERN_DETECT: begin
                    pattern_detect <= {pattern_detect[2:0], data};
                end
                SHIFT: begin
                    shift_counter <= shift_counter + 1;
                end
                default: begin
                    shift_counter <= 3'b000;
                end
            endcase
        end
    end
    
    // Output Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 1'b0;
            counting  <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    shift_ena <= 1'b0;
                    counting  <= 1'b0;
                    done <= 1'b0;
                end
                PATTERN_DETECT: begin
                    shift_ena <= 1'b0;
                    counting  <= 1'b0;
                    done <= 1'b0;
                end
                SHIFT: begin
                    shift_ena <= 1'b1;
                end
                COUNT: begin
                    shift_ena <= 1'b0;
                    counting  <= 1'b1;
                end
                DONE: begin
                    counting  <= 1'b0;
                    done <= 1'b1;
                end
                default: begin
                    shift_ena <= 1'b0;
                    counting  <= 1'b0;
                    done <= 1'b0;
                end
            endcase
        end
    end
    
endmodule
