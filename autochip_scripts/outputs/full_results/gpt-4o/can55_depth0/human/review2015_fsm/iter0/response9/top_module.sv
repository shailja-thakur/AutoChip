module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    typedef enum reg [2:0] {
        S_IDLE = 3'b000,
        S_DETECT1 = 3'b001,
        S_DETECT2 = 3'b010,
        S_DETECT3 = 3'b011,
        S_SHIFT = 3'b100,
        S_COUNT = 3'b101,
        S_DONE = 3'b110
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
            bit_counter <= 3'b0;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            if (shift_ena)
                bit_counter <= bit_counter + 1;
            else
                bit_counter <= 3'b0;
        end
    end

    always @(*) begin
        shift_ena = 0;
        counting = 0;
        done = 0;
        next_state = state;
        
        case(state)
            S_IDLE: begin
                if (data == 1) next_state = S_DETECT1;
            end

            S_DETECT1: begin
                if (data == 1) next_state = S_DETECT2;
                else next_state = S_IDLE;
            end

            S_DETECT2: begin
                if (data == 0) next_state = S_DETECT3;
                else next_state = S_IDLE;
            end

            S_DETECT3: begin
                if (data == 1) next_state = S_SHIFT;
                else next_state = S_IDLE;
            end

            S_SHIFT: begin
                shift_ena = 1;
                if (bit_counter == 4'd4) next_state = S_COUNT;
                else next_state = S_SHIFT;
            end

            S_COUNT: begin
                counting = 1;
                if (done_counting) next_state = S_DONE;
                else next_state = S_COUNT;
            end

            S_DONE: begin
                done = 1;
                if (ack) next_state = S_IDLE;
                else next_state = S_DONE;
            end

            default: next_state = S_IDLE;
        endcase
    end
endmodule
