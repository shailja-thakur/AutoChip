module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State declarations
    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        SHIFT,
        COUNT,
        WAIT_ACK
    } state_t;
    
    state_t current_state, next_state;
    
    logic [3:0] shift_count;
    reg [3:0] pattern_shift;
    
    // State Transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic and Output Logic
    always_comb begin
        // Default assignments
        shift_ena = 0;
        counting = 0;
        done = 0;
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                // Shift in bits to detect pattern 1101
                pattern_shift = {pattern_shift[2:0], data};
                if (pattern_shift == 4'b1101) begin
                    next_state = SHIFT;
                end
            end
            
            SHIFT: begin
                shift_ena = 1;
                if (shift_count == 4) begin
                    next_state = COUNT;
                end else begin
                    next_state = SHIFT;
                end
            end
            
            COUNT: begin
                counting = 1;
                if (done_counting) begin
                    next_state = WAIT_ACK;
                end else begin
                    next_state = COUNT;
                end
            end
            
            WAIT_ACK: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_ACK;
                end
            end
        endcase
    end
    
    // Shift count logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_count <= 0;
        end else if (current_state == SHIFT) begin
            shift_count <= shift_count + 1;
        end else begin
            shift_count <= 0;
        end
    end
    
    // Pattern shift register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            pattern_shift <= 4'b0;
        end else if (current_state == IDLE) begin
            pattern_shift <= {pattern_shift[2:0], data};
        end else begin
            pattern_shift <= 4'b0;
        end
    end

endmodule
