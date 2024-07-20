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
        IDLE=3'b000,        // Initial state, waiting for 1101
        S1=3'b001,          // Got 1
        S11=3'b010,         // Got 11
        S110=3'b011,        // Got 110
        S1101=3'b100,       // Pattern 1101 detected
        SHIFT=3'b101,       // Shift in 4 more bits to determine duration
        COUNT=3'b110,       // Waiting for the counters
        DONE=3'b111         // Notify user and wait for ack
    } state_t;

    state_t state, next_state;
    reg [1:0] shift_count;

    // State transition on positive clock edge
    always @(posedge clk) begin
        if (reset) begin
            state       <= IDLE;
            shift_count <= 0;
        end
        else begin
            state <= next_state;
            if (state == SHIFT)
                shift_count <= shift_count + 1;
            else
                shift_count <= 0;
        end
    end

    // Next state logic
    always @(*) begin
        next_state  = state;  // Default state remains unchanged
        shift_ena   = 0;
        counting    = 0;
        done        = 0;

        case (state)
            IDLE: begin
                if (data == 1) next_state = S1;
                else           next_state = IDLE;
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
                next_state   = SHIFT;
                shift_ena    = 1;
            end
            SHIFT: begin
                shift_ena    = 1;
                if (shift_count == 2'b11) next_state = COUNT;
                else next_state = SHIFT;
            end
            COUNT: begin
                counting     = 1;
                if (done_counting) next_state = DONE;
                else next_state = COUNT;
            end
            DONE: begin
                done = 1;
                if (ack) next_state = IDLE;
                else next_state = DONE;
            end
        endcase
    end

endmodule
