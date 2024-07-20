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
        SEQ1        = 3'b001,
        SEQ11       = 3'b010,
        SEQ110      = 3'b011,
        SEQ1101     = 3'b100,
        SHIFT       = 3'b101,
        COUNTING    = 3'b110,
        DONE        = 3'b111
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_counter;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 0;
        end else begin
            state <= next_state;
            if (state == SHIFT) begin
                shift_counter <= shift_counter + 1;
            end else begin
                shift_counter <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default to staying in the same state
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            IDLE: begin
                if (data == 1) next_state = SEQ1;
            end
            SEQ1: begin
                if (data == 1) next_state = SEQ11;
                else next_state = IDLE;
            end
            SEQ11: begin
                if (data == 0) next_state = SEQ110;
                else next_state = IDLE;
            end
            SEQ110: begin
                if (data == 1) next_state = SEQ1101;
                else next_state = IDLE;
            end
            SEQ1101: begin
                if (data == 1) begin
                    next_state = SHIFT;
                    shift_ena = 1;
                end else begin
                    next_state = IDLE;
                end
            end
            SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 3) next_state = COUNTING; // After 4 cycles (0-3)
            end
            COUNTING: begin
                counting = 1;
                if (done_counting) next_state = DONE;
            end
            DONE: begin
                done = 1;
                if (ack) next_state = IDLE;
            end
        endcase
    end

endmodule
