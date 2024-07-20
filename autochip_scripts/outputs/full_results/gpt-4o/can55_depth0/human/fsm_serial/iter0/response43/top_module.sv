module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    // State encoding
    typedef enum logic [2:0] {
        IDLE       = 3'b000,
        START_BIT  = 3'b001,
        DATA_BIT   = 3'b010,
        STOP_BIT   = 3'b011,
        DONE_STATE = 3'b100,
        ERROR      = 3'b101
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_count;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'd0;
            done <= 1'b0;
        end
        else begin
            current_state <= next_state;
            // Count bits when in DATA_BIT state
            if (current_state == DATA_BIT) 
                bit_count <= bit_count + 1;
            else
                bit_count <= 3'd0;

            // Done signal is only high in DONE_STATE
            if (current_state == DONE_STATE)
                done <= 1'b1;
            else
                done <= 1'b0;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            START_BIT: begin
                next_state = DATA_BIT;
            end
            DATA_BIT: begin
                if (bit_count == 3'd7) // Received all 8 data bits
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1) // Stop bit check
                    next_state = DONE_STATE;
                else
                    next_state = ERROR;
            end
            DONE_STATE: begin
                next_state = IDLE;
            end
            ERROR: begin
                if (in == 1'b1) // Wait for stop bit
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
