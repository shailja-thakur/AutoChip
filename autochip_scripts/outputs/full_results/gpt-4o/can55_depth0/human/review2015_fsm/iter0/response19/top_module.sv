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
        IDLE = 3'd0,
        S1 = 3'd1,
        S11 = 3'd2,
        S110 = 3'd3,
        S1101 = 3'd4,
        SHIFT = 3'd5,
        COUNT = 3'd6,
        DONE = 3'd7
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] shift_count;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            shift_count <= 3'd0;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT) begin
                if (shift_count < 3'd3)
                    shift_count <= shift_count + 3'd1;
                else
                    shift_count <= 3'd0;
            end else begin
                shift_count <= 3'd0;
            end
        end
    end

    // State machine
    always @(*) begin
        // Default outputs
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (data)
                    next_state = S1;
            end
            S1: begin
                if (~data)
                    next_state = IDLE;
                else
                    next_state = S11;
            end
            S11: begin
                if (data)
                    next_state = S110;
                else
                    next_state = S1;
            end
            S110: begin
                if (data)
                    next_state = S1101;
                else
                    next_state = IDLE;
            end
            S1101: begin
                if (data) begin
                    shift_ena = 1'b1;
                    next_state = SHIFT;
                end else begin
                    next_state = IDLE;
                end
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_count == 3'd3) begin
                    next_state = COUNT;
                end
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

endmodule
