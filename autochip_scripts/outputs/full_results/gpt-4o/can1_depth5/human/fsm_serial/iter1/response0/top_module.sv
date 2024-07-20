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
    logic [3:0] bit_cnt;  // 4 bits to count up to 9 (8 data bits + 1 stop bit)
    logic [7:0] data;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_cnt <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    always_comb begin
        next_state = state;
        done = 0;
        case (state)
            IDLE: begin
                if (in == 0)  // Detect start bit
                    next_state = START_BIT;
            end
            START_BIT: begin
                if (bit_cnt == 1) begin
                    next_state = RECEIVE_DATA;
                    bit_cnt = 0;  // Reset bit counter for data bits
                end else begin
                    next_state = START_BIT;
                    bit_cnt = bit_cnt + 1;
                end
            end
            RECEIVE_DATA: begin
                if (bit_cnt == 8)  // Received 8 data bits
                    next_state = VERIFY_STOP;
                else
                    next_state = RECEIVE_DATA;
            end
            VERIFY_STOP: begin
                if (in == 1) begin  // Verify stop bit
                    done = 1;
                    next_state = IDLE;
                end else
                    next_state = ERROR;
            end
            ERROR: begin
                if (in == 1)  // Wait until the line is idle again
                    next_state = IDLE;
            end
        endcase
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            bit_cnt <= 0;
        end else begin
            case (state)
                START_BIT: begin
                    bit_cnt <= bit_cnt + 1;
                end
                RECEIVE_DATA: begin
                    data[bit_cnt] <= in;
                    bit_cnt <= bit_cnt + 1;
                end
                VERIFY_STOP, IDLE: begin
                    bit_cnt <= 0;
                end
            endcase
        end
    end
endmodule
