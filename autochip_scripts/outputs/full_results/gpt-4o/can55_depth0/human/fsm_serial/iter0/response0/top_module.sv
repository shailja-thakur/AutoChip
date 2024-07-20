module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    // State encoding
    typedef enum logic [2:0] {
        IDLE,       // Waiting for start bit
        START_BIT,  // Start bit detected
        DATA_BITS,  // Receiving data bits
        STOP_BIT    // Awaiting stop bit
    } state_t;

    state_t state, next_state;
    logic [2:0] bit_count; // Counter to keep track of received data bits
    logic [7:0] data;      // Register to store the received byte

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            done <= 1'b0;
            bit_count <= 3'd0;
            data <= 8'd0;
        end else begin
            state <= next_state;
            if (state == START_BIT || state == DATA_BITS) begin
                bit_count <= bit_count + 1;
                if (state == DATA_BITS) begin
                    data[bit_count] <= in;
                end
            end else if (state == STOP_BIT) begin
                bit_count <= 3'd0;
            end
        end
    end

    always_comb begin
        next_state = state;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START_BIT; // Start bit detected
                end
            end
            START_BIT: begin
                next_state = DATA_BITS; // Move to data receiving state
            end
            DATA_BITS: begin
                if (bit_count == 3'd7) begin
                    next_state = STOP_BIT; // After 8 bits, check for stop bit
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin
                    done = 1'b1; // Proper byte received
                    next_state = IDLE;
                end else begin
                    next_state = IDLE; // Wait until line goes idle again
                end
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
