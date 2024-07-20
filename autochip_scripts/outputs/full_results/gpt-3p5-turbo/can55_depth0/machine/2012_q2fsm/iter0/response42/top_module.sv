module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000; // Initial state is A
        else
            case (state)
                3'b000: // State A
                    state <= (w == 1'b1) ? 3'b001 : 3'b000; // Transition to B if w is 1, else stay in A
                3'b001: // State B
                    state <= (w == 1'b1) ? 3'b010 : 3'b011; // Transition to C if w is 1, else transition to D
                3'b010: // State C
                    state <= (w == 1'b1) ? 3'b110 : 3'b011; // Transition to E if w is 1, else transition to D
                3'b011: // State D
                    state <= (w == 1'b1) ? 3'b111 : 3'b000; // Transition to F if w is 1, else transition to A
                3'b100: // State E (not reachable, added for completeness)
                    state <= 3'b110; // Stay in state E
                3'b101: // State F (not reachable, added for completeness)
                    state <= 3'b110; // Transition to C
                3'b110: // State E
                    state <= (w == 1'b1) ? 3'b110 : 3'b010; // Transition to E if w is 1, else transition to C
                3'b111: // State F
                    state <= (w == 1'b1) ? 3'b110 : 3'b011; // Transition to E if w is 1, else transition to D
            endcase
    end
    
    assign z = (state == 3'b110 || state == 3'b111) ? 1'b1 : 1'b0;
endmodule
