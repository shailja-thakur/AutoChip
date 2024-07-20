module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE       = 3'b000,
        START_BIT  = 3'b001,
        DATA_BITS  = 3'b010,
        STOP_BIT   = 3'b011,
        ERROR      = 3'b100
    } state_t;

    state_t state, next_state;
    logic [2:0] bit_counter;

    // State transition logic (synchronous)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'b000;
        end
        else begin
            state <= next_state;
            if (state == DATA_BITS) begin
                bit_counter <= bit_counter + 1;
            end else if (state == IDLE || state == START_BIT || state == STOP_BIT || state == ERROR) begin
                bit_counter <= 3'b000;
            end
        end
    end

    // Next state logic (combinational)
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START_BIT;
                done = 1'b0;
            end
            START_BIT: begin
                next_state = DATA_BITS;
                done = 1'b0;
            end
            DATA_BITS: begin
                if (bit_counter == 3'b111) // All 8 data bits have been received
                    next_state = STOP_BIT;
                done = 1'b0;
            end
            STOP_BIT: begin
                if (in == 1'b1) // Detect stop bit
                    next_state = IDLE;
                else
                    next_state = ERROR;
                done = (in == 1'b1);
            end
            ERROR: begin
                if (in == 1'b1) // Wait for line to be idle (stop bit)
                    next_state = IDLE;
                done = 1'b0;
            end
            default: begin
                next_state = IDLE;
                done = 1'b0;
            end
        endcase
    end

endmodule
