module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State definitions
    typedef enum reg [2:0] {
        IDLE       = 3'b000,
        START_BIT  = 3'b001,
        DATA_BITS  = 3'b010,
        STOP_BIT   = 3'b011,
        WAIT_STOP  = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;  // 3 bits to count up to 7 or up to 8

    // Output logic for 'done'
    always @(*) begin
        if (state == STOP_BIT && in == 1'b1)
            done = 1'b1;
        else
            done = 1'b0;
    end

    // State transition logic (next state logic)
    always @(*) begin
        case(state)
            IDLE: begin
                if (in == 1'b0)    // Start bit detected
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end

            START_BIT: begin
                next_state = DATA_BITS;
            end

            DATA_BITS: begin
                if (bit_count == 3'd7)   // If all 8 data bits received (count 0-7)
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end

            STOP_BIT: begin
                if (in == 1'b1)
                    next_state = IDLE;     // Successfully received a byte
                else
                    next_state = WAIT_STOP; // Wait for stop bit
            end

            WAIT_STOP: begin
                if (in == 1'b1)
                    next_state = IDLE;     // Successfully received a stop bit after waiting
                else
                    next_state = WAIT_STOP; // Continue waiting for stop bit
            end

            default: next_state = IDLE;
        endcase
    end

    // State flip-flops (state register)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Bit counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'd0;
        end else if (state == DATA_BITS) begin
            bit_count <= bit_count + 1;
        end else if (state == IDLE || state == START_BIT || state == STOP_BIT) begin
            bit_count <= 3'd0;
        end
    end
endmodule
