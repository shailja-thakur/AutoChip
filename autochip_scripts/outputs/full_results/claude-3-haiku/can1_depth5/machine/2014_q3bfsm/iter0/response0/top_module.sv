module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= 3'b000; // Initialize state to A
    end
    else begin
        case (state)
            3'b000: // State A
                if (x) state <= 3'b001; // If x is high, go to state B
                else state <= 3'b000; // If x is low, stay in state A
            3'b001: // State B
                if (x) state <= 3'b100; // If x is high, go to state E
                else state <= 3'b001; // If x is low, stay in state B
            3'b010: // State C
                if (x) state <= 3'b001; // If x is high, go to state B
                else state <= 3'b010; // If x is low, stay in state C
            3'b011: // State D
                if (x) state <= 3'b010; // If x is high, go to state C
                else state <= 3'b001; // If x is low, go to state B
            3'b100: // State E
                if (x) state <= 3'b100; // If x is high, stay in state E
                else state <= 3'b011; // If x is low, go to state D
            default:
                state <= 3'b000; // Default to state A
        endcase
    end
end

// Output logic
assign z = (state == 3'b011) || (state == 3'b100); // Output is high when in state D or E

endmodule
