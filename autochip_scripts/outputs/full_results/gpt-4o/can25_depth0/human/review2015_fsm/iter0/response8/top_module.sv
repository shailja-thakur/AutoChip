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
        S_IDLE = 3'b000,
        S_DETECT_1 = 3'b001,
        S_DETECT_11 = 3'b010,
        S_DETECT_110 = 3'b011,
        S_DETECT_1101 = 3'b100,
        S_SHIFT = 3'b101,
        S_COUNTING = 3'b110,
        S_DONE = 3'b111
    } state_t;

    state_t state, next_state;
    int shift_counter;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_counter <= 0;
        end else begin
            case (state)
                S_IDLE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
                S_DETECT_1: begin
                end
                S_DETECT_11: begin
                end
                S_DETECT_110: begin
                end
                S_DETECT_1101: begin
                end
                S_SHIFT: begin
                    shift_ena <= 1;
                    shift_counter <= shift_counter + 1;
                    if (shift_counter == 4) begin
                        shift_ena <= 0;
                    end
                end
                S_COUNTING: begin
                    counting <= 1;
                end
                S_DONE: begin
                    counting <= 0;
                    done <= 1;
                end
            endcase
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            S_IDLE: begin
                if (data)
                    next_state = S_DETECT_1;
            end
            S_DETECT_1: begin
                if (data)
                    next_state = S_DETECT_11;
                else
                    next_state = S_IDLE;
            end
            S_DETECT_11: begin
                if (data)
                    next_state = S_DETECT_110;
                else
                    next_state = S_IDLE;
            end
            S_DETECT_110: begin
                if (data)
                    next_state = S_DETECT_1101;
                else
                    next_state = S_IDLE;
            end
            S_DETECT_1101: begin
                if (data)
                    next_state = S_SHIFT;
                else
                    next_state = S_IDLE;
            end
            S_SHIFT: begin
                if (shift_counter == 4)
                    next_state = S_COUNTING;
            end
            S_COUNTING: begin
                if (done_counting)
                    next_state = S_DONE;
            end
            S_DONE: begin
                if (ack)
                    next_state = S_IDLE;
            end
        endcase
    end

endmodule
