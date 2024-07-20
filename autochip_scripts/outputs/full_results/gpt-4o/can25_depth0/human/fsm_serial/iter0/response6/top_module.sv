module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    typedef enum reg [2:0] {
        IDLE,
        START,
        DATA,
        STOP,
        ERROR_WAIT
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] data_shift_reg;

    // State transition logic
    always @(*) begin
        next_state = state;
        done = 0;
        case (state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit (0)
                    next_state = START;
            end
            START: begin
                if (in == 1'b0) // Confirm start bit is still 0
                    next_state = DATA;
                else
                    next_state = IDLE; // False start, go back to idle
            end
            DATA: begin
                if (bit_counter == 3'd7) // Check if all 8 data bits received
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            STOP: begin
                if (in == 1'b1) begin // Check for stop bit (1)
                    next_state = IDLE;
                    done = 1;
                end else
                    next_state = ERROR_WAIT; // Error, wait for the next stop bit
            end
            ERROR_WAIT: begin
                if (in == 1'b1) // Look for the line returning to 1
                    next_state = IDLE;
                else
                    next_state = ERROR_WAIT;
            end
        endcase
    end

    // State flip-flops with active-high synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 0;
            data_shift_reg <= 8'b0;
        end else begin
            state <= next_state;
            if (state == DATA) begin
                data_shift_reg <= {in, data_shift_reg[7:1]}; // Shift in the incoming data bit
                bit_counter <= bit_counter + 1'b1;
            end else if (state != DATA) begin
                bit_counter <= 0;
            end
        end
    end

endmodule
