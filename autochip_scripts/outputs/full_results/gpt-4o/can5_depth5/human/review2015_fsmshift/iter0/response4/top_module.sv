module top_module(
	input clk,
	input reset,
	output reg shift_ena);

    reg [2:0] state, next_state; // 3-bit state to count 0 to 4
    
    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic and output logic
    always @(*) begin
        case (state)
            0: begin
                next_state = 1;
                shift_ena = 1;
            end
            1: begin
                next_state = 2;
                shift_ena = 1;
            end
            2: begin
                next_state = 3;
                shift_ena = 1;
            end
            3: begin
                next_state = 4;
                shift_ena = 1;
            end
            4: begin
                next_state = 4; // Stay in state 4
                shift_ena = 0;  // No shift enable
            end
            default: begin
                next_state = 4;
                shift_ena = 0; // Default case to avoid latches
            end
        endcase
    end
endmodule
