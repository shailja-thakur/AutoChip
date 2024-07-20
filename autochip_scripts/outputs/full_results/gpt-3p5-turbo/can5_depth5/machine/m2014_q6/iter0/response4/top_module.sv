module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // Internal one-bit signal to hold the current state
    reg [2:0] state;
	
    // Next state logic
    always @(posedge clk) begin
        if (reset) begin // Reset condition
            state <= 3'b000; // Reset to state A
        end else begin // Transition condition
            case(state)
                3'b000: state <= w ? 3'b000 : 3'b001; // Transition from state A to A or B
                3'b001: state <= w ? 3'b010 : 3'b011; // Transition from state B to C or D
                3'b010: state <= w ? 3'b011 : 3'b100; // Transition from state C to D or E
                3'b011: state <= w ? 3'b000 : 3'b101; // Transition from state D to A or F
                3'b100: state <= w ? 3'b100 : 3'b010; // Transition from state E to E or D
                3'b101: state <= w ? 3'b011 : 3'b010; // Transition from state F to C or D
                default: state <= 3'b000; // Default state transition to handle any unexpected cases
            endcase
        end
    end
	
    // Output logic
    always @(state) begin
        z <= (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0; // Output z is high in state E or F, low otherwise
    end

endmodule
