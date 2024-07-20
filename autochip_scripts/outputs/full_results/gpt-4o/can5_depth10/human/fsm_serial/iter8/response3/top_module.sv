module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // Declare state encoding
    typedef enum reg [2:0] {
        IDLE       = 3'b000,
        START_BIT  = 3'b001,
        DATA_BITS  = 3'b010,
        STOP_BIT   = 3'b011,
        ERROR      = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [3:0] bit_count; // Using 4-bit to avoid overflow when counting up to 8

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state == DATA_BITS) begin
                bit_count <= bit_count + 1;
            end
            else begin
                bit_count <= 3'b0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Detect start bit (0)
                    next_state = START_BIT;
                end
                else begin
                    next_state = IDLE;
                end
            end
            
            START_BIT: begin
                next_state = DATA_BITS;
            end
            
            DATA_BITS: begin
                if (bit_count == 3'd7) begin
                    next_state = STOP_BIT;
                end
                else begin
                    next_state = DATA_BITS;
                end
            end
            
            STOP_BIT: begin
                if (in == 1'b1) begin // Detect stop bit (1)
                    done = 1'b1; // Byte correctly received
                    next_state = IDLE;
                end
                else begin
                    next_state = ERROR; // Stop bit incorrect
                end
            end
            
            ERROR: begin
                if (in == 1'b1) begin // Wait for line to go idle (1)
                    next_state = IDLE;
                end
                else begin
                    next_state = ERROR;
                end
            end
            
            default: next_state = IDLE;
        endcase
    end
endmodule
