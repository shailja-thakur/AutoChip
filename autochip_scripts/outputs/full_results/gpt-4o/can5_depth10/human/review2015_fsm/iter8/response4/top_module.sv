module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        DETECT1 = 3'b001,
        DETECT2 = 3'b010,
        DETECT3 = 3'b011,
        DETECT4 = 3'b100,
        SHIFT = 3'b101,
        WAIT_COUNT = 3'b110,
        DONE = 3'b111
    } state_t;

    state_t current_state, next_state;

    // Counter for shifting bits
    reg [1:0] shift_counter;

    // State register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and outputs
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            shift_counter <= 2'b0;
        end else begin
            case(current_state)
                IDLE: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (data) begin
                        next_state <= DETECT1;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                DETECT1: begin
                    if (data) begin
                        next_state <= DETECT2;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                DETECT2: begin
                    if (~data) begin
                        next_state <= DETECT3;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                DETECT3: begin
                    if (data) begin
                        next_state <= DETECT4;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                DETECT4: begin
                    if (data) begin
                        next_state <= SHIFT;
                        shift_ena <= 1'b1;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                SHIFT: begin
                    shift_ena <= 1'b1;
                    if (shift_counter == 2'b11) begin
                        next_state <= WAIT_COUNT;
                        shift_ena <= 1'b0;
                    end else begin
                        shift_counter <= shift_counter + 1;
                    end
                end
                WAIT_COUNT: begin
                    counting <= 1'b1;
                    if (done_counting) begin
                        next_state <= DONE;
                        counting <= 1'b0;
                    end
                end
                DONE: begin
                    done <= 1'b1;
                    if (ack) begin
                        next_state <= IDLE;
                        done <= 1'b0;
                    end
                end
            endcase
        end
    end

    // Update next_state
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            next_state <= IDLE;
        end else begin
            case (current_state)
                IDLE: begin
                    if (data && shift_ena == 1'b0) begin
                        next_state <= DETECT1;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                DETECT1: begin
                    if (data) begin
                        next_state <= DETECT2;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                DETECT2: begin
                    if (~data) begin
                        next_state <= DETECT3;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                DETECT3: begin
                    if (data) begin
                        next_state <= DETECT4;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                DETECT4: begin
                    if (data) begin
                        next_state <= SHIFT;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                SHIFT: begin
                    if (shift_counter == 2'b11) begin
                        next_state <= WAIT_COUNT;
                    end else begin
                        next_state <= SHIFT;
                    end
                end
                WAIT_COUNT: begin
                    if (done_counting) begin
                        next_state <= DONE;
                    end else begin
                        next_state <= WAIT_COUNT;
                    end
                end
                DONE: begin
                    if (ack) begin
                        next_state <= IDLE;
                    end else begin
                        next_state <= DONE;
                    end
                end
            endcase
        end
    end

endmodule
