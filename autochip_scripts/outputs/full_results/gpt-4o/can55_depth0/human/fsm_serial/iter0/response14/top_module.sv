module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    typedef enum logic [2:0] {
        IDLE = 3'd0,
        START = 3'd1,
        DATA = 3'd2,
        STOP = 3'd3,
        ERROR = 3'd4
    } state_t;

    state_t state, next_state;
    logic [2:0] bit_counter;   // Counter for received data bits
    logic [7:0] data_byte;     // To store the received data byte

    // State Transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next State Logic
    always_comb begin
        next_state = state; // default to stay in the same state
        done = 1'b0; // default done signal
        case (state)
            IDLE: begin
                if (in == 1'b0) // Detect falling edge as start bit
                    next_state = START;
            end
            START: begin
                if (in == 1'b0) // Confirm it's still a valid start bit
                    next_state = DATA;
                else
                    next_state = IDLE; // False start, go back to IDLE
            end
            DATA: begin
                if (bit_counter < 3'd7)
                    next_state = DATA;
                else
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) // Check for valid stop bit
                    done = 1'b1;
                else
                    next_state = ERROR; // Stop bit error, go to ERROR state
                next_state = IDLE; // After STOP, go back to IDLE for next byte
            end
            ERROR: begin
                if (in == 1'b1) // Wait until line is idle (1)
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Bit Counter and Data Byte Storage
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 3'd0;
            data_byte <= 8'd0;
        end
        else begin
            case (state)
                START: begin
                    bit_counter <= 3'd0;
                end
                DATA: begin
                    data_byte[bit_counter] <= in; // Store incoming bit
                    bit_counter <= bit_counter + 3'd1;
                end
                STOP: begin
                    bit_counter <= 3'd0;
                end
                ERROR: begin
                    // Remain in ERROR, bit_counter remains 0
                end
                default: begin
                    bit_counter <= 3'd0;
                end
            endcase
        end
    end

endmodule
