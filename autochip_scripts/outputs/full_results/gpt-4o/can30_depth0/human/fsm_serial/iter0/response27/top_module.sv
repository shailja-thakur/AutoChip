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
        DONE       = 3'b100
    } state_t;
    
    state_t state, next_state;
    logic [2:0] bit_counter;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'd0;
        end else begin
            state <= next_state;
            if (state == DATA_BITS)
                bit_counter <= bit_counter + 1;
            else
                bit_counter <= 3'd0;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit (0)
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_counter == 3'd7) // All 8 data bits received
                    next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1) begin // Stop bit (1) detected
                    next_state = DONE;
                end else begin
                    next_state = IDLE;
                end
            end
            DONE: begin
                done = 1'b1;
                if (in == 1'b1) // Go back to idle
                    next_state = IDLE;
            end
        endcase
    end
endmodule
