module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START_BIT = 3'b001,
        RECEIVE_DATA = 3'b010,
        VERIFY_STOP = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    state_t state, next_state;
    logic [3:0] bit_cnt;  // 4 bits to count up to 8 (0 to 7 for data bits)
    logic [7:0] data;

    // State and output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_cnt <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            if (state == VERIFY_STOP && next_state == IDLE) begin
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

    // Next-state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 0)  // Detect start bit
                    next_state = START_BIT;
            end
            START_BIT: begin
                if (bit_cnt == 1) begin
                    next_state = RECEIVE_DATA;
                end
            end
            RECEIVE_DATA: begin
                if (bit_cnt == 8)  // Received 8 data bits
                    next_state = VERIFY_STOP;
            end
            VERIFY_STOP: begin
                if (in == 1) begin  // Verify stop bit
                    next_state = IDLE;
                end else
                    next_state = ERROR;  // Stop bit error
            end
            ERROR: begin
                if (in == 1)  // Wait until the line is idle again
                    next_state = IDLE;
            end
        endcase
    end

    // Bit counter and data shift logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_cnt <= 0;
            data <= 0;
        end else begin
            case (state)
                IDLE: begin
                    bit_cnt <= 0;
                    data <= 0;
                end
                START_BIT: begin
                    // Increment bit counter to transition to RECEIVE_DATA state
                    bit_cnt <= bit_cnt + 1;
                end
                RECEIVE_DATA: begin
                    data[bit_cnt] <= in;  // Shift in data bits
                    bit_cnt <= bit_cnt + 1;
                end
                VERIFY_STOP: begin
                    bit_cnt <= 0;  // Reset bit counter
                end
                ERROR: begin
                    bit_cnt <= 0;  // Reset bit counter
                end
            endcase
        end
    end

endmodule
