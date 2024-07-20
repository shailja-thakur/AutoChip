module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

    // State definitions
    typedef enum logic [3:0] {
        IDLE       = 4'b0000,
        START_BIT  = 4'b0001,
        DATA_BIT_0 = 4'b0010,
        DATA_BIT_1 = 4'b0011,
        DATA_BIT_2 = 4'b0100,
        DATA_BIT_3 = 4'b0101,
        DATA_BIT_4 = 4'b0110,
        DATA_BIT_5 = 4'b0111,
        DATA_BIT_6 = 4'b1000,
        DATA_BIT_7 = 4'b1001,
        STOP_BIT   = 4'b1010,
        ERROR      = 4'b1011
    } state_t;
    
    state_t state, next_state;
    integer bit_count;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            done <= 0;
        end
        else begin
            state <= next_state;
            case (state)
                DATA_BIT_0, DATA_BIT_1, DATA_BIT_2, DATA_BIT_3, DATA_BIT_4,
                DATA_BIT_5, DATA_BIT_6, DATA_BIT_7: bit_count <= bit_count + 1;
                
                default: bit_count <= 0;
            endcase
        end
    end

    always_comb begin
        // Default values
        next_state = state;
        done = 0;
        
        case (state)
            IDLE: begin
                if (in == 1'b0)  // Start bit detected
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            
            START_BIT: begin
                next_state = DATA_BIT_0;
            end
            
            DATA_BIT_0: next_state = DATA_BIT_1;
            DATA_BIT_1: next_state = DATA_BIT_2;
            DATA_BIT_2: next_state = DATA_BIT_3;
            DATA_BIT_3: next_state = DATA_BIT_4;
            DATA_BIT_4: next_state = DATA_BIT_5;
            DATA_BIT_5: next_state = DATA_BIT_6;
            DATA_BIT_6: next_state = DATA_BIT_7;
            
            DATA_BIT_7: next_state = STOP_BIT;
            
            STOP_BIT: begin
                if (in == 1'b1) begin
                    done = 1;
                    next_state = IDLE;  // Successfully received a byte
                end
                else begin
                    next_state = ERROR;  // Stop bit was incorrect
                end
            end
            
            ERROR: begin
                if (in == 1'b1)  // Wait for idle line
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
        endcase
    end
    
endmodule
