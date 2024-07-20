module top_module(
	input clk,
	input reset,
	input data,
    // Added reg keyword to output signals
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define states
    localparam IDLE = 2'b00;
    localparam DETECTING = 2'b01;
    localparam WAITING = 2'b10;
    localparam TIMEOUT = 2'b11;
  
    // Define current and next state variables
    reg [1:0] state, next_state;
    
    // State register
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
  
    // State transition logic
    always @(*)
    begin
        next_state = state;
        case(state)
            IDLE:
                if (data == 1'b1 && $bits(shift_ena) < 4) // Pattern 1101 detection
                    next_state = DETECTING;
                else
                    next_state = IDLE;
            DETECTING:
                if ($bits(shift_ena) == 4) // Shift_ena asserted for 4 clock cycles
                    next_state = WAITING;
                else
                    next_state = DETECTING;
            WAITING:
                if (done_counting) // Wait for done_counting to become high
                    next_state = TIMEOUT;
                else
                    next_state = WAITING;
            TIMEOUT:
                if (ack) // Wait for ack to become high
                    next_state = IDLE;
                else
                    next_state = TIMEOUT;
        endcase
    end

    // Output logic
    always @(posedge clk)
    begin
        // Reset output signals
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
        
        // Update output signals based on current state  
        case(state)
            IDLE:
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
            DETECTING:
                shift_ena <= 1'b1;
                counting <= 1'b0;
                done <= 1'b0;
            WAITING:
                shift_ena <= 1'b0;
                counting <= 1'b1;
                done <= 1'b0;
            TIMEOUT:
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b1;
        endcase
    end
endmodule
