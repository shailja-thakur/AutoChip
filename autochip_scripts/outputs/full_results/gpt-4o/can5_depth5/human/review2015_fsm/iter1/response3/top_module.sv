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

    typedef enum logic [2:0] {
        IDLE,        // Initial state, waiting for 1101
        S1,          // Got 1
        S11,         // Got 11
        S110,        // Got 110
        S1101,       // Pattern 1101 detected
        SHIFT,       // Shift in 4 more bits to determine duration
        COUNT,       // Waiting for the counters
        DONE         // Notify user and wait for ack
    } state_t;

    state_t state, next_state;
    reg [1:0] shift_count;

    // State transition on positive clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state       <= IDLE;
            shift_count <= 0;
            shift_ena   <= 0;
            counting    <= 0;
            done        <= 0;
        end
        else begin
            state <= next_state;
            if (state == SHIFT && next_state == SHIFT) begin
                shift_count <= shift_count + 1;
            end
            else if (state == IDLE || state == COUNT || state == DONE) begin
                shift_count <= 0;
            end

            shift_ena <= (next_state == SHIFT);
            counting  <= (next_state == COUNT);
            done      <= (next_state == DONE);
        end
    end

    // Next state logic
    always @(*) begin
        next_state  = state;  // Default state remains unchanged

        case (state)
            IDLE: begin
                if (data == 1) next_state = S1;
            end
            S1: begin
                if (data == 1) next_state = S11;
                else           next_state = IDLE;
            end
            S11: begin
                if (data == 0) next_state = S110;
                else           next_state = IDLE;
            end
            S110: begin
                if (data == 1) next_state = S1101;
                else           next_state = IDLE;
            end
            S1101: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                if (shift_count == 2'b11) next_state = COUNT;
            end
            COUNT: begin
                if (done_counting) next_state = DONE;
            end
            DONE: begin
                if (ack) next_state = IDLE;
            end
        endcase
    end

endmodule
