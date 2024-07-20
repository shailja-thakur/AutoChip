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
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        DETECT1 = 3'b001,
        DETECT11 = 3'b010,
        DETECT110 = 3'b011,
        DETECT1101 = 3'b100,
        SHIFTING = 3'b101,
        COUNTING = 3'b110,
        DONE = 3'b111
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_count;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_count <= 3'b000;
        end else begin
            state <= next_state;
            if (state == SHIFTING)
                shift_count <= shift_count + 3'b001;
            else
                shift_count <= 3'b000;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (data) next_state = DETECT1;
            end
            DETECT1: begin
                if (!data) next_state = IDLE;
                else next_state = DETECT11;
            end
            DETECT11: begin
                if (!data) next_state = DETECT110;
                else next_state = IDLE;
            end
            DETECT110: begin
                if (data) next_state = DETECT1101;
                else next_state = IDLE;
            end
            DETECT1101: begin
                if (!data) next_state = IDLE;
                else next_state = SHIFTING;
            end
            SHIFTING: begin
                shift_ena = 1'b1;
                if (shift_count == 3'b100) next_state = COUNTING;
            end
            COUNTING: begin
                counting = 1'b1;
                if (done_counting) next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack) next_state = IDLE;
            end
        endcase
    end

endmodule
