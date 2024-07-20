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

    // State declaration
    typedef enum logic [2:0] {
        STATE_IDLE = 3'b000,
        STATE_DETECT_1 = 3'b001,
        STATE_DETECT_11 = 3'b010,
        STATE_DETECT_110 = 3'b011,
        STATE_DETECT_1101 = 3'b100,
        STATE_SHIFTING = 3'b101,
        STATE_COUNTING = 3'b110,
        STATE_DONE = 3'b111
    } state_t;

    state_t state, next_state;
    reg [1:0] shift_count; // 2-bit counter to track 4 clock cycles for shift enable

    // State transition logic (Sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_IDLE;
            shift_count <= 2'b00;
        end else begin
            state <= next_state;
            if (state == STATE_SHIFTING)
                shift_count <= shift_count + 2'b01;
            else
                shift_count <= 2'b00;
        end
    end

    // Next state logic & Output logic (Combinational)
    always @(*) begin
        // Default values
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        
        case (state)
            STATE_IDLE: begin
                if (data == 1'b1)
                    next_state = STATE_DETECT_1;
            end

            STATE_DETECT_1: begin
                if (data == 1'b1)
                    next_state = STATE_DETECT_11;
                else
                    next_state = STATE_IDLE;
            end

            STATE_DETECT_11: begin
                if (data == 1'b0)
                    next_state = STATE_DETECT_110;
                else
                    next_state = STATE_IDLE;
            end

            STATE_DETECT_110: begin
                if (data == 1'b1)
                    next_state = STATE_DETECT_1101;
                else
                    next_state = STATE_IDLE;
            end

            STATE_DETECT_1101: begin
                if (data == 1'b1) // Remain in this state if an unexpected bit comes
                    next_state = STATE_DETECT_1;
                else
                    next_state = STATE_SHIFTING;
            end

            STATE_SHIFTING: begin
                shift_ena = 1'b1;
                if (shift_count == 2'b11) // After 4 cycles of shifting
                    next_state = STATE_COUNTING;
            end

            STATE_COUNTING: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = STATE_DONE;
            end

            STATE_DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = STATE_IDLE;
            end
        endcase
    end

endmodule
