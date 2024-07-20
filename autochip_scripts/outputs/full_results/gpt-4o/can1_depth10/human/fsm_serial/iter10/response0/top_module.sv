module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State enumeration
    typedef enum reg [2:0] {
        IDLE       = 3'b000,
        START_BIT  = 3'b001,
        DATA_BITS  = 3'b010,
        STOP_BIT   = 3'b011,
        WAIT_STOP  = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;  // 3 bits to count up to 7

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 1'b0)    // Start bit detected
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end

            START_BIT: begin
                next_state = DATA_BITS;
            end

            DATA_BITS: begin
                if (bit_count == 3'd7) // If all 8 data bits received (count 0-7)
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end

            STOP_BIT: begin
                if (in == 1'b1)
                    next_state = IDLE; // Successfully received a byte
                else
                    next_state = WAIT_STOP; // Wait for stop bit
            end

            WAIT_STOP: begin
                if (in == 1'b1)
                    next_state = IDLE; // Successfully received a stop bit after waiting
                else
                    next_state = WAIT_STOP; // Continue waiting for stop bit
            end

            default: next_state = IDLE;
        endcase
    end

    // Output and other synchronous logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 1'b0;
            bit_count <= 3'd0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    bit_count <= 3'd0;
                end
                
                START_BIT: begin
                    done <= 1'b0;
                end
                
                DATA_BITS: begin
                    done <= 1'b0;
                    bit_count <= bit_count + 1;
                end
                
                STOP_BIT: begin
                    if (in == 1'b1)
                        done <= 1'b1;
                    else
                        done <= 1'b0;
                end
                
                WAIT_STOP: begin
                    done <= 1'b0;
                end
                
                default: done <= 1'b0;
            endcase
        end
    end
    
endmodule
