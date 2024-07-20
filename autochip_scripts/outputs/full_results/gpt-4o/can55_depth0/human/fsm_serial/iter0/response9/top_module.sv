module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    // State encoding
    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;  // Counter for the data bits

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic and outputs
    always_comb begin
        next_state = current_state;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START;
            end
            START: begin
                next_state = DATA;
                bit_count = 3'b000;
            end
            DATA: begin
                bit_count = bit_count + 1'b1;
                if (bit_count == 3'b111) // 8 data bits received
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin // Detect stop bit
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    // If stop bit is not received, wait until the line goes idle
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
