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
        IDLE        = 3'b000,
        PATTERN1    = 3'b001,
        PATTERN2    = 3'b010,
        PATTERN3    = 3'b011,
        PATTERN4    = 3'b100,
        SHIFT       = 3'b101,
        COUNT       = 3'b110,
        DONE        = 3'b111
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_count; // 3-bit counter to count to 4

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_count <= 0;
        end
        else begin
            state <= next_state;

            case (state)
                IDLE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
                PATTERN4: begin
                    shift_ena <= 1;
                    shift_count <= 0;
                end
                SHIFT: begin
                    shift_ena <= 1;
                    shift_count <= shift_count + 1;
                end
                COUNT: begin
                    shift_ena <= 0;
                    counting <= 1;
                end
                DONE: begin
                    counting <= 0;
                    done <= 1;
                end
            endcase
        end
    end

    always @* begin
        next_state = state;
        case (state)
            IDLE: if (data == 1) next_state = PATTERN1;
            PATTERN1: if (data == 1) next_state = PATTERN2; else next_state = IDLE;
            PATTERN2: if (data == 0) next_state = PATTERN3; else next_state = IDLE;
            PATTERN3: if (data == 1) next_state = PATTERN4; else next_state = IDLE;
            PATTERN4: next_state = SHIFT;
            SHIFT: if (shift_count == 3) next_state = COUNT;
            COUNT: if (done_counting) next_state = DONE;
            DONE: if (ack) next_state = IDLE;
        endcase
    end
endmodule
