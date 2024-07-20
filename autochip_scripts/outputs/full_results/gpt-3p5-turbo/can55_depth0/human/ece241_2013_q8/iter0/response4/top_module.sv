module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

    reg [1:0] state;  // Two-bit state representation
    
    always @(posedge clk or negedge aresetn)
    begin
        if (~aresetn)
            state <= 2'b00;  // Reset state
        else
        begin
            case (state)
                2'b00: if (x) state <= 2'b01; else state <= 2'b00;  // Transition from state 0 to state 1 if x = 1
                2'b01: if (x) state <= 2'b10; else state <= 2'b00;  // Transition from state 1 to state 2 if x = 1
                2'b10: if (x) begin
                            state <= 2'b01;
                            z <= 1'b1;  // Output z is asserted to logic-1 when "101" sequence is detected
                        end
                        else state <= 2'b00;  // Transition from state 2 to state 0 if x = 0
                default: state <= 2'b00;
            endcase
        end
    end
endmodule
