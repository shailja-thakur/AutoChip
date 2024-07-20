module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S1 = 3'b001,
        S11 = 3'b010,
        S110 = 3'b011,
        S1101 = 3'b100,
        SHIFT = 3'b101,
        COUNT = 3'b110,
        DONE = 3'b111
    } state_t;
    
    state_t state, next_state;
    reg [2:0] shift_counter;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default to hold state
        case (state)
            IDLE: begin
                if (data)
                    next_state = S1;
            end
            S1: begin
                if (data)
                    next_state = S11;
                else
                    next_state = IDLE;
            end
            S11: begin
                if (data)
                    next_state = S110;
                else
                    next_state = IDLE;
            end
            S110: begin
                if (data)
                    next_state = S1101;
                else
                    next_state = IDLE;
            end
            S1101: begin
                if (data)
                    next_state = SHIFT;
                else
                    next_state = IDLE;
            end
            SHIFT: begin
                if (shift_counter == 4)
                    next_state = COUNT;
            end
            COUNT: begin
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

    // Output logic and shift_counter handling
    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_counter <= 0;
        end
        else begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            case (state)
                SHIFT: begin
                    shift_ena <= 1;
                    shift_counter <= shift_counter + 1;
                end
                COUNT: begin
                    counting <= 1;
                end
                DONE: begin
                    done <= 1;
                end
                default: begin
                    shift_counter <= 0;
                end
            endcase
        end
    end

endmodule
