module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START_BIT = 3'b001,
        RECEIVE_DATA = 3'b010,
        VERIFY_STOP = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    state_t state, next_state;
    logic [2:0] bit_cnt;
    logic [7:0] data;
    
    // State transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always_comb begin
        next_state = state;
        done = 0;
        case (state)
            IDLE: begin
                if (in == 0) // Detect start bit
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = RECEIVE_DATA;
                bit_cnt = 0;
            end
            RECEIVE_DATA: begin
                if (bit_cnt == 3'd7) // Received 8 data bits
                    next_state = VERIFY_STOP;
                else
                    next_state = RECEIVE_DATA;
            end
            VERIFY_STOP: begin
                if (in == 1) begin // Verify stop bit
                    done = 1;
                    next_state = IDLE;
                end else
                    next_state = ERROR;
            end
            ERROR: begin
                if (in == 1) // Wait until the line is idle again
                    next_state = IDLE;
            end
        endcase
    end
    
    // Data reception and bit counter
    always_ff @(posedge clk) begin
        if (state == RECEIVE_DATA) begin
            data[bit_cnt] <= in;
            bit_cnt <= bit_cnt + 1;
        end else begin
            bit_cnt <= 0;
        end
    end
endmodule
