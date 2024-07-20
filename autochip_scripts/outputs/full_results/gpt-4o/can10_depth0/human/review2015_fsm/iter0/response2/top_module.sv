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

    typedef enum reg [2:0] {
        IDLE,
        DETECT1,
        DETECT11,
        DETECT110,
        DETECT1101,
        SHIFT,
        WAIT_COUNT,
        DONE
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_counter;

    // State transition logic
    always @ (posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @ (*) begin
        next_state = state; // Default to stay in the same state
        case(state)
            IDLE: begin
                if (data == 1'b1) next_state = DETECT1;
            end
            
            DETECT1: begin
                if (data == 1'b1) next_state = DETECT11;
                else next_state = IDLE;
            end
            
            DETECT11: begin
                if (data == 1'b0) next_state = DETECT110;
                else next_state = IDLE;
            end
            
            DETECT110: begin
                if (data == 1'b1) next_state = DETECT1101;
                else next_state = IDLE;
            end
            
            DETECT1101: begin
                next_state = SHIFT;
            end
            
            SHIFT: begin
                if (shift_counter == 4) next_state = WAIT_COUNT;
            end
            
            WAIT_COUNT: begin
                if (done_counting == 1'b1) next_state = DONE;
            end
            
            DONE: begin
                if (ack == 1'b1) next_state = IDLE;
            end
        endcase
    end

    // Output logic and shift counter
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_counter <= 0;
        end else begin
            case(state)
                IDLE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                    shift_counter <= 0;
                end
                
                DETECT1, DETECT11, DETECT110, DETECT1101: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end

                SHIFT: begin
                    shift_ena <= 1;
                    shift_counter <= shift_counter + 1;
                    if (shift_counter == 4)
                        shift_ena <= 0;
                end
                
                WAIT_COUNT: begin
                    shift_ena <= 0;
                    counting <= 1;
                    done <= 0;
                end

                DONE: begin
                    counting <= 0;
                    done <= 1;
                end
            endcase
        end
    end

endmodule
