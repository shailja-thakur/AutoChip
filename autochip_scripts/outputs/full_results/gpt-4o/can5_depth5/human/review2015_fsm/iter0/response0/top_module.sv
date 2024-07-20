module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State Encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        SHIFT = 3'b100,
        COUNT = 3'b101,
        DONE = 3'b110
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_count;

    // State Machine
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case (state)
            IDLE: 
                if (data == 1'b1)
                    next_state = S1;
                else
                    next_state = IDLE;
            S1: 
                if (data == 1'b1)
                    next_state = S2;
                else
                    next_state = IDLE;
            S2: 
                if (data == 1'b0)
                    next_state = S3;
                else
                    next_state = IDLE;
            S3:
                if (data == 1'b1)
                    next_state = SHIFT;
                else
                    next_state = IDLE;
            SHIFT:
                if (shift_count == 3'b100)
                    next_state = COUNT;
                else
                    next_state = SHIFT;
            COUNT:
                if (done_counting)
                    next_state = DONE;
                else
                    next_state = COUNT;
            DONE:
                if (ack)
                    next_state = IDLE;
                else
                    next_state = DONE;
            default:
                next_state = IDLE;
        endcase
    end

    // Output and Shift Counter Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            shift_count <= 3'b000;
        end else begin
            case (state)
                IDLE: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    shift_count <= 3'b000;
                end
                S1, S2, S3: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                SHIFT: begin
                    shift_ena <= 1'b1;
                    counting <= 1'b0;
                    done <= 1'b0;
                    shift_count <= shift_count + 1;
                end
                COUNT: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                    done <= 1'b0;
                end
                DONE: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            endcase
        end
    end
endmodule
