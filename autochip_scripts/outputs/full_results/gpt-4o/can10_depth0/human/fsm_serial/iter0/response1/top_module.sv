module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE        = 3'b000,
        START_BIT   = 3'b001,
        DATA_BITS   = 3'b010,
        STOP_BIT    = 3'b011,
        ERROR       = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    
    // Synchronous state and bit count update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b000;
        end else begin
            state <= next_state;
            if (state == DATA_BITS) begin
                bit_count <= bit_count + 3'b001;
            end else begin
                bit_count <= 3'b000;
            end
        end
    end

    // Next state logic
    always @(*) begin
        done = 1'b0;
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Detected start bit
                    next_state = START_BIT;
                end
            end
            START_BIT: begin
                next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_count == 3'b111) begin // After 8 bits
                    next_state = STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin // Stop bit is correct
                    done = 1'b1;
                    next_state = IDLE;
                end else begin // Error detected
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin // Wait until line goes idle
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule
