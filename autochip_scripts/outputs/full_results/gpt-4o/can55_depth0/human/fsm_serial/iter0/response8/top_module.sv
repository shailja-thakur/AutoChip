module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE        = 3'd0,
        START_BIT   = 3'd1,
        DATA_BITS   = 3'd2,
        STOP_BIT    = 3'd3,
        CHECK_STOP  = 3'd4
    } state_t;

    state_t state, next_state;
    reg [3:0] bit_counter; // To count data bits

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 4'd0;
        end else begin
            state <= next_state;
            if (state == DATA_BITS) bit_counter <= bit_counter + 1;
            else bit_counter <= 4'd0;
        end
    end

    // Next state logic
    always @(*) begin
        done = 1'b0;
        case (state)
            IDLE: begin
                if (!in) next_state = START_BIT; // Detected start bit (0)
                else next_state = IDLE;
            end

            START_BIT: begin
                next_state = DATA_BITS;
            end

            DATA_BITS: begin
                if (bit_counter == 4'd7) next_state = STOP_BIT; // 8 data bits received
                else next_state = DATA_BITS;
            end

            STOP_BIT: begin
                next_state = CHECK_STOP;
            end

            CHECK_STOP: begin
                if (in) begin
                    done = 1'b1;  // Correct stop bit (1)
                    next_state = IDLE;
                end else begin
                    next_state = CHECK_STOP; // Wait for a valid stop bit
                end
            end

            default: next_state = IDLE;

        endcase
    end

endmodule
