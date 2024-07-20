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
    logic [3:0] bit_cnt;
    logic [7:0] data;
    logic done_flag;

    // State and output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_cnt <= 0;
            done <= 0;
            done_flag <= 0;
        end else begin
            state <= next_state;
            if (done_flag) begin
                done <= 1;
                done_flag <= 0;
            end else begin
                done <= 0;
            end
        end
    end

    // Next-state logic
    always_comb begin
        next_state = state;
        done_flag = 0;  // Initialize done_flag to prevent inadvertent latches
        case (state)
            IDLE: begin
                if (in == 0)  // Detect start bit
                    next_state = START_BIT;
            end
            START_BIT: begin
                if (bit_cnt == 1) begin
                    next_state = RECEIVE_DATA;
                end else begin
                    next_state = START_BIT;
                end
            end
            RECEIVE_DATA: begin
                if (bit_cnt == 7)  // Received 8 data bits (counting from 0)
                    next_state = VERIFY_STOP;
                else
                    next_state = RECEIVE_DATA;
            end
            VERIFY_STOP: begin
                if (in == 1) begin  // Verify stop bit
                    next_state = IDLE;
                    done_flag = 1;
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
                    if (bit_cnt == 0) begin
                        bit_cnt <= 1;
                    end
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
