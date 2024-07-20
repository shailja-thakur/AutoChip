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
    typedef enum logic [2:0] {
        IDLE        = 3'b000,
        PATTERN_1   = 3'b001,
        PATTERN_2   = 3'b010,
        PATTERN_3   = 3'b011,
        PATTERN_4   = 3'b100,
        SHIFT       = 3'b101,
        COUNTING    = 3'b110,
        DONE        = 3'b111
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_counter;  // 3 bits counter to count 0 to 4

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;   // Default to staying in same state
        case (state)
            IDLE: begin
                if (data == 1'b1) next_state = PATTERN_1;
            end
            PATTERN_1: begin
                if (data == 1'b1) next_state = PATTERN_2;
                else next_state = IDLE;
            end
            PATTERN_2: begin
                if (data == 1'b0) next_state = PATTERN_3;
                else next_state = IDLE;
            end
            PATTERN_3: begin
                if (data == 1'b1) next_state = PATTERN_4;
                else next_state = IDLE;
            end
            PATTERN_4: begin
                if (data == 1'b1) next_state = SHIFT;
                else next_state = IDLE;
            end
            SHIFT: begin
                if (shift_counter == 3'h4) next_state = COUNTING;
            end
            COUNTING: begin
                if (done_counting) next_state = DONE;
            end
            DONE: begin
                if (ack) next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic and shift counter
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            shift_counter <= 3'h0;
        end else begin
            case (next_state)
                IDLE: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    shift_counter <= 3'h0;
                end
                PATTERN_1, PATTERN_2, PATTERN_3, PATTERN_4: begin
                    shift_ena <= 1'b0;
                end
                SHIFT: begin
                    shift_ena <= 1'b1;
                    shift_counter <= shift_counter + 1;
                end
                COUNTING: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                end
                DONE: begin
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            endcase
        end
    end

endmodule
