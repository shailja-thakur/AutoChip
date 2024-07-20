module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State encoding
    typedef enum reg [2:0] {
        IDLE,           // 000
        DETECT_1,       // 001
        DETECT_11,      // 010
        DETECT_110,     // 011
        DETECT_1101,    // 100
        SHIFT,          // 101
        COUNT,          // 110
        DONE            // 111
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_counter;

    // State transition logic (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic (combinational)
    always @(*) begin
        next_state = state; // Default to self-state
        case (state)
            IDLE: begin
                if (data == 1)
                    next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data == 1)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end
            DETECT_11: begin
                if (data == 0)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end
            DETECT_110: begin
                if (data == 1)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end
            DETECT_1101: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                if (shift_counter == 3)
                    next_state = COUNT;
            end
            COUNT: begin
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

    // Output logic and shift counter control
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_counter <= 0;
        end
        else begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            case (state)
                SHIFT: begin
                    shift_ena <= 1;
                    shift_counter <= shift_counter + 1;
                end
                COUNT: begin
                    counting <= 1;
                end
                DONE: begin
                    done <= 1;
                end
            endcase

            // Reset shift_counter when transitioning to SHIFT state
            if (state == DETECT_1101)
                shift_counter <= 0;
        end
    end
endmodule
