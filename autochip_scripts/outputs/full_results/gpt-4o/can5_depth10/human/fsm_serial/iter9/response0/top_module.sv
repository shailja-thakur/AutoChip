module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT,
        ERROR
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            
            // Update bit_count only in DATA_BITS state
            if (state == DATA_BITS) begin
                if (bit_count == 3'd7) begin
                    bit_count <= 3'd0;
                end else begin
                    bit_count <= bit_count + 1;
                end
            end else begin
                bit_count <= 3'd0;
            end
        end
    end

    always @(*) begin
        done = 1'b0;
        next_state = state;
        case(state)
            IDLE: begin
                if (in == 1'b0) begin // Detect start bit (logic 0)
                    next_state = START_BIT;
                end
            end
            
            START_BIT: begin
                if (in == 1'b0) begin // Confirm we are still in start bit
                    next_state = DATA_BITS;
                end else begin
                    next_state = IDLE; // If `in` is not 0, it is an error
                end
            end
            
            DATA_BITS: begin
                if (bit_count == 3'd7) begin
                    next_state = STOP_BIT;
                end else begin
                    next_state = DATA_BITS;
                end
            end
            
            STOP_BIT: begin
                if (in == 1'b1) begin // Expect stop bit (logic 1)
                    done = 1'b1; // Assert done signal
                    next_state = IDLE;
                end else begin
                    next_state = ERROR; // If stop bit is not 1, go to error state
                end
            end
            
            ERROR: begin
                if (in == 1'b1) begin // Wait for line to return to idle state (logic 1)
                    next_state = IDLE;
                end
            end
            
            default: next_state = IDLE;
        endcase
    end
endmodule
