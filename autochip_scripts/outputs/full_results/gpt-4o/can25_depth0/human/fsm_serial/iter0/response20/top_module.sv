module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State Encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        DONE = 3'b100,
        ERROR = 3'b101
    } state_t;

    state_t current_state, next_state;
    reg [3:0] bit_counter;

    // State Register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 4'b0;
        end
        else begin
            current_state <= next_state;
            if (current_state == DATA || current_state == STOP) begin
                bit_counter <= bit_counter + 1;
            end
            else begin
                bit_counter <= 4'b0;
            end
        end
    end

    // Next State Logic and Output Logic
    always_comb begin
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (!in) begin  // looking for start bit '0'
                    next_state = START;
                end
            end

            START: begin
                if (in) begin  // error in start bit
                    next_state = ERROR;
                end
                else begin  // start bit valid, move to data reception
                    next_state = DATA;
                end
            end

            DATA: begin
                if (bit_counter == 4'd8) begin  // after receiving 8 data bits
                    next_state = STOP;
                end
            end

            STOP: begin
                if (in) begin  // stop bit '1' is correct
                    next_state = DONE;
                end
                else begin  // stop bit is incorrect
                    next_state = ERROR;
                end
            end

            DONE: begin
                done = 1'b1;
                if (!in) begin  // look for new start bit
                    next_state = START;
                end
                else begin
                    next_state = IDLE;
                end
            end

            ERROR: begin  // wait for idle line before checking for new byte
                if (in) begin
                    next_state = IDLE;
                end
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
