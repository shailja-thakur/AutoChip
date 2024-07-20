module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [2:0] state, next_state;
    reg [3:0] shift_counter;

    // State encoding
    localparam S_IDLE       = 3'b000,
               S_DETECT_1   = 3'b001,
               S_DETECT_11  = 3'b010,
               S_DETECT_110 = 3'b011,
               S_DETECT_1101= 3'b100,
               S_SHIFT      = 3'b101,
               S_COUNTING   = 3'b110,
               S_DONE       = 3'b111;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            S_IDLE: begin
                if (data == 1'b1)
                    next_state = S_DETECT_1;
                else
                    next_state = S_IDLE;
            end
            S_DETECT_1: begin
                if (data == 1'b1)
                    next_state = S_DETECT_11;
                else
                    next_state = S_IDLE;
            end
            S_DETECT_11: begin
                if (data == 1'b0)
                    next_state = S_DETECT_110;
                else
                    next_state = S_IDLE;
            end
            S_DETECT_110: begin
                if (data == 1'b1)
                    next_state = S_DETECT_1101;
                else
                    next_state = S_IDLE;
            end
            S_DETECT_1101: begin
                next_state = S_SHIFT;
            end
            S_SHIFT: begin
                if (shift_counter == 4)
                    next_state = S_COUNTING;
                else
                    next_state = S_SHIFT;
            end
            S_COUNTING: begin
                if (done_counting)
                    next_state = S_DONE;
                else
                    next_state = S_COUNTING;
            end
            S_DONE: begin
                if (ack)
                    next_state = S_IDLE;
                else
                    next_state = S_DONE;
            end
            default: next_state = S_IDLE;
        endcase
    end

    // Output logic and shift counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done     <= 0;
            shift_counter <= 0;
        end
        else begin
            shift_ena <= 0;  // Default value
            case (state)
                S_SHIFT: begin
                    shift_ena <= 1;
                    if (shift_counter < 4)
                        shift_counter <= shift_counter + 1;
                end
                S_COUNTING: begin
                    counting <= 1;
                end
                S_DONE: begin
                    done <= 1;
                end
                default: begin
                    shift_counter <= 0;
                    counting <= 0;
                    done <= 0;
                end
            endcase
        end
    end
endmodule
