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
    typedef enum logic [3:0] {
        S_IDLE    = 4'b0000, // Initial state, look for pattern 1101
        S_1       = 4'b0001, // Detecting the first bit (1)
        S_11      = 4'b0010, // Detecting the second bit (1)
        S_110     = 4'b0011, // Detecting the third bit (0)
        S_1101    = 4'b0100, // Pattern 1101 detected
        S_SHIFT   = 4'b0101, // Shift in 4 more bits
        S_COUNT   = 4'b0110, // Waiting for counters to finish counting
        S_DONE    = 4'b0111  // Notify the user and wait for ack
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_count;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S_IDLE: begin
                if (data) next_state = S_1;
                else next_state = S_IDLE;
            end
            S_1: begin
                if (data) next_state = S_11;
                else next_state = S_IDLE;
            end
            S_11: begin
                if (!data) next_state = S_110;
                else next_state = S_IDLE;
            end
            S_110: begin
                if (data) next_state = S_1101;
                else next_state = S_IDLE;
            end
            S_1101: begin
                next_state = S_SHIFT;
            end
            S_SHIFT: begin
                if (shift_count == 3) next_state = S_COUNT;
                else next_state = S_SHIFT;
            end
            S_COUNT: begin
                if (done_counting) next_state = S_DONE;
                else next_state = S_COUNT;
            end
            S_DONE: begin
                if (ack) next_state = S_IDLE;
                else next_state = S_DONE;
            end
            default: next_state = S_IDLE;
        endcase
    end

    // Output logic and Shift counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_count <= 0;
        end
        else begin
            shift_ena <= (state == S_SHIFT);
            counting <= (state == S_COUNT);
            done <= (state == S_DONE);

            if (state == S_SHIFT) begin
                if (shift_ena) shift_count <= shift_count + 1;
            end
            else begin
                shift_count <= 0;
            end
        end
    end

endmodule
