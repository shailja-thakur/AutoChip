module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

// Define the states for the finite-state machine
typedef enum logic [2:0] {
    IDLE,
    START_PATTERN,
    SHIFT_DATA,
    COUNTING,
    DONE
} state_t;

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE:
                if (data == 4'b1101) begin
                    state <= START_PATTERN;
                    shift_ena <= 1;
                end else begin
                    state <= IDLE;
                    shift_ena <= 0;
                end
            START_PATTERN:
                state <= SHIFT_DATA;
                shift_ena <= 1;
            SHIFT_DATA:
                if (shift_ena == 4) begin
                    state <= COUNTING;
                    shift_ena <= 0;
                    counting <= 1;
                end else begin
                    state <= SHIFT_DATA;
                    shift_ena <= shift_ena + 1;
                end
            COUNTING:
                if (done_counting) begin
                    state <= DONE;
                    counting <= 0;
                    done <= 1;
                end else begin
                    state <= COUNTING;
                    counting <= 1;
                end
            DONE:
                if (ack) begin
                    state <= START_PATTERN;
                    shift_ena <= 1;
                    done <= 0;
                end else begin
                    state <= DONE;
                end
            default:
                state <= IDLE;
        endcase
    end
end

endmodule
