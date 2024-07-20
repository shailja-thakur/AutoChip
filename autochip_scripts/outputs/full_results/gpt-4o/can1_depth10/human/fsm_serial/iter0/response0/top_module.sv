module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    
    // State definitions
    typedef enum reg [2:0] {
        IDLE       = 3'b000,
        START_BIT  = 3'b001,
        DATA_BITS  = 3'b010,
        STOP_BIT   = 3'b011,
        CHECK_STOP = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_count;

    // State transition logic (next state logic)
    always @(*) begin
        case(state)
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
                if (bit_count == 3'd7)   // If all 8 data bits received
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end
            
            STOP_BIT: begin
                next_state = CHECK_STOP;
            end

            CHECK_STOP: begin
                if (in == 1'b1)
                    next_state = IDLE;     // Successfully received a byte
                else
                    next_state = STOP_BIT; // Wait for stop bit
            end
            
            default: next_state = IDLE;
        endcase
    end

    // State flip-flops (state register)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Output logic and bit counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'd0;
            done <= 1'b0;
        end else begin
            case(state)
                IDLE: begin
                    bit_count <= 3'd0;
                    done <= 1'b0;
                end
                
                START_BIT: begin
                    bit_count <= 3'd0;
                end
                
                DATA_BITS: begin
                    bit_count <= bit_count + 1;
                end
                
                STOP_BIT: begin
                    done <= 1'b0;
                end
                
                CHECK_STOP: begin
                    if (in == 1'b1)
                        done <= 1'b1; // Successfully received a byte
                    else
                        done <= 1'b0; // Reset done signal if stop bit not detected
                end
                
                default: begin
                    bit_count <= 3'd0;
                    done <= 1'b0;
                end
            endcase
        end
    end

endmodule
