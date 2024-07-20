module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );
    
    // State declaration
    typedef enum reg [2:0] {
        IDLE,
        PATTERN_DETECT,
        SHIFT_ENA,
        COUNTING,
        DONE
    } state_t;
    
    state_t state, next_state;
    
    // Shift register for pattern detection
    reg [3:0] shift_reg;
    
    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 0;
        end
        else begin
            state <= next_state;
            shift_reg <= {shift_reg[2:0], data};  // Shift in the new bit
        end
    end
    
    // Next state and output logic
    always @(*) begin
        // Default Outputs
        shift_ena = 0;
        counting = 0;
        done = 0;
        
        case (state)
            IDLE: begin
                // Look for the start pattern 1101
                if (shift_reg == 4'b1101) begin
                    next_state = SHIFT_ENA;
                end
                else begin
                    next_state = IDLE;
                end
            end
            
            SHIFT_ENA: begin
                shift_ena = 1;
                // Remain in this state for 4 clock cycles
                next_state = (shift_reg == 4'b0001) ? COUNTING : SHIFT_ENA;
            end
            
            COUNTING: begin
                counting = 1;
                if (done_counting) begin
                    next_state = DONE;
                end
                else begin
                    next_state = COUNTING;
                end
            end
            
            DONE: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = DONE;
                end
            end
            
            default: next_state = IDLE;
        endcase
    end
endmodule
