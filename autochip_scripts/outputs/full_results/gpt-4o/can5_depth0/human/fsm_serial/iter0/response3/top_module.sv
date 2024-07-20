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
        DATA_BITS = 3'b010,
        STOP_BIT = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] byte_data;

    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (in == 1'b0)  // Start bit detected
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA_BITS;
                bit_count = 3'd0;  // Initialize bit count for data bits
            end
            DATA_BITS: begin
                if (bit_count < 3'd7) begin
                    bit_count = bit_count + 3'd1;
                    next_state = DATA_BITS;
                end else begin
                    next_state = STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin  // Stop bit detected
                    done = 1'b1;
                    next_state = IDLE;
                end else begin  // Stop bit error
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin  // Wait for stop bit to appear
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Data bit shift register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            byte_data <= 8'd0;
        end else if (state == DATA_BITS) begin
            byte_data <= {in, byte_data[7:1]};
        end
    end

endmodule
