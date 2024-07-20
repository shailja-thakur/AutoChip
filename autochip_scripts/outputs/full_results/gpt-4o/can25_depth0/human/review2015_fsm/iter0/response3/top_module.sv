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
        IDLE,
        MATCH1,
        MATCH2,
        MATCH3,
        MATCH4,
        SHIFT,
        COUNT,
        DONE
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bits_received;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (data == 1'b1) 
                    next_state = MATCH1;
                else
                    next_state = IDLE;
            end
            MATCH1: begin
                if (data == 1'b1)
                    next_state = MATCH2;
                else
                    next_state = IDLE;
            end
            MATCH2: begin
                if (data == 1'b0)
                    next_state = MATCH3;
                else
                    next_state = IDLE;
            end
            MATCH3: begin
                if (data == 1'b1)
                    next_state = MATCH4;
                else
                    next_state = IDLE;
            end
            MATCH4: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                if (bits_received == 3'b100)
                    next_state = COUNT;
                else
                    next_state = SHIFT;
            end
            COUNT: begin
                if (done_counting)
                    next_state = DONE;
                else
                    next_state = COUNT;
            end
            DONE: begin
                if (ack)
                    next_state = IDLE;
                else
                    next_state = DONE;
            end
            default: 
                next_state = IDLE;
        endcase
    end

    // Output and state logic
    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            bits_received <= 0;
        end else begin
            case (next_state)
                IDLE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                    bits_received <= 0;
                end
                MATCH1, MATCH2, MATCH3: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
                MATCH4: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
                SHIFT: begin
                    shift_ena <= 1;
                    bits_received <= bits_received + 1;
                    counting <= 0;
                    done <= 0;
                end
                COUNT: begin
                    shift_ena <= 0;
                    counting <= 1;
                    done <= 0;
                end
                DONE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 1;
                end
                default: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
            endcase
        end
    end
endmodule
