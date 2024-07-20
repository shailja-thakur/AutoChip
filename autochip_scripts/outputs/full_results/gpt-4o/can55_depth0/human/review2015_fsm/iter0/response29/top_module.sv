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
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100,
        SHIFT = 3'b101,
        COUNT = 3'b110,
        DONE = 3'b111
    } state_t;

    state_t state, next_state;
    reg [1:0] shift_counter;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data)
                    next_state = S1;
            end
            S1: begin
                if (data)
                    next_state = S2;
                else
                    next_state = IDLE;
            end
            S2: begin
                if (data)
                    next_state = S3;
                else
                    next_state = IDLE;
            end
            S3: begin
                if (data)
                    next_state = S4;
                else
                    next_state = IDLE;
            end
            S4: begin
                if (!data)
                    next_state = SHIFT;
                else
                    next_state = IDLE;
            end
            SHIFT: begin
                if (shift_counter == 2'd3)
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

    // Output and counter control
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_counter <= 0;
        end else begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            case (next_state)
                SHIFT: begin
                    shift_ena <= 1;
                    shift_counter <= shift_counter + 1;
                end
                COUNT: begin
                    counting <= 1;
                    shift_counter <= 0;
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
