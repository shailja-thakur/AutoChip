module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        SHIFT = 3'b001,
        COUNT = 3'b010,
        DONE = 3'b011,
        WAIT = 3'b100
    } state_t;

    state_t state, next_state;
    reg [3:0] shift_count;
    reg [3:0] pattern_buffer;

    always_ff @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_count <= 4'b0;
            pattern_buffer <= 4'b0;
        end
        else begin
            state <= next_state;
            if (state == SHIFT) begin
                shift_count <= shift_count + 1;
            end else begin
                shift_count <= 4'b0;
            end
            if (state == IDLE) begin
                pattern_buffer <= {pattern_buffer[2:0], data};
            end
        end
    end

    always_comb begin
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (pattern_buffer == 4'b1101) begin
                    next_state = SHIFT;
                    shift_ena = 1'b1;
                end else begin
                    next_state = IDLE;
                end
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_count == 4) begin
                    next_state = COUNT;
                end else begin
                    next_state = SHIFT;
                end
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = DONE;
                end else begin
                    next_state = COUNT;
                end
            end
            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = DONE;
                end
            end
        endcase
    end

endmodule
