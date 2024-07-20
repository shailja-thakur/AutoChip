module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define state encoding
    typedef enum reg [2:0] {
        IDLE          = 3'b000,
        PATTERN_DET   = 3'b001,
        SHIFT         = 3'b010,
        COUNT         = 3'b011,
        DONE          = 3'b100
    } state_t;
    
    // State registers
    reg [2:0] state, next_state;
    reg [3:0] pattern_shift;
    reg [1:0] shift_count;
    
    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Combinational logic for next state and outputs
    always @(*) begin
        // Default outputs
        shift_ena = 0;
        counting = 0;
        done = 0;
        
        case (state)
            IDLE: begin
                if (pattern_shift == 4'b1101) begin
                    next_state = PATTERN_DET;
                end else begin
                    next_state = IDLE;
                end
            end
            
            PATTERN_DET: begin
                shift_ena = 1;
                if (shift_count == 2'b11) begin
                    next_state = COUNT;
                end else begin
                    next_state = SHIFT;
                end
            end
            
            SHIFT: begin
                shift_ena = 1;
                next_state = PATTERN_DET;
            end
            
            COUNT: begin
                counting = 1;
                if (done_counting) begin
                    next_state = DONE;
                end else begin
                    next_state = COUNT;
                end
            end
            
            DONE: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = DONE;
                end
            end
            
            default: next_state = IDLE;
        endcase
    end
    
    // Shift register to detect pattern and count cycles
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pattern_shift <= 4'b0000;
            shift_count <= 2'b00;
        end else if (state == IDLE) begin
            pattern_shift <= {pattern_shift[2:0], data};
        end else if (state == PATTERN_DET || state == SHIFT) begin
            shift_count <= shift_count + 1;
        end else if (state == COUNT) begin
            shift_count <= 2'b00;
        end
    end
    
endmodule
