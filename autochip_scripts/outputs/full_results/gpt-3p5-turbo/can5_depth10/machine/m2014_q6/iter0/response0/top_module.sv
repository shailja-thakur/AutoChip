module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
reg z;

always @(posedge clk) begin
    if (reset)
        state <= 3'b000; // State A
    else begin
        case (state)
            3'b000: // State A
                state <= w ? 3'b000 : 3'b001; // Transition to state B or stay in state A based on w
            3'b001: // State B
                state <= w ? 3'b011 : 3'b010; // Transition to state D or state C based on w
            3'b010: // State C
                state <= w ? 3'b011 : 3'b100; // Transition to state D or state E based on w
            3'b011: // State D
                state <= w ? 3'b000 : 3'b101; // Transition to state A or state F based on w
            3'b100: // State E
                state <= w ? 3'b011 : 3'b100; // Transition to state D or stay in state E based on w
            3'b101: // State F
                state <= w ? 3'b011 : 3'b010; // Transition to state D or state C based on w
        endcase
    end
    
    z <= (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0; // Set z high for state E or state F, low otherwise
end

endmodule
