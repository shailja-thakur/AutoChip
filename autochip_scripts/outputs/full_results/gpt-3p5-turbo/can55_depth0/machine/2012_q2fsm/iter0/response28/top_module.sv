module top_module (
    input clk,
    input reset,
    input w,
    output reg z // Added reg keyword for an output register
);
    reg [2:0] state; // 3-bit register to represent the states
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 0; // Reset to initial state when reset is asserted
        else begin
            case(state)
                3'd0: if (w) state <= 3'd1; else state <= 3'd0; // State A: transition to B if w=1, otherwise stay in A
                3'd1: if (w) state <= 3'd2; else state <= 3'd3; // State B: transition to C if w=1, otherwise transition to D
                3'd2: if (w) state <= 3'd4; else state <= 3'd3; // State C: transition to E if w=1, otherwise transition to D
                3'd3: if (w) state <= 3'd5; else state <= 3'd0; // State D: transition to F if w=1, otherwise transition to A
                3'd4: state <= 3'd2; // State E: always stay in E
                3'd5: state <= 3'd2; // State F: always transition to C
                default: state <= 3'd0;
            endcase
        end
    end
    
    assign z = (state == 3'd4 || state == 3'd5) ? 1'b1 : 1'b0; // Set z to 1 when state is E or F, otherwise set to 0
    
endmodule
