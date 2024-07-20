module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

always_comb begin
    case(state)
        2'b00:  // State A
            begin
                if(in)
                    next_state = 2'b01;  // Transition to state B
                else
                    next_state = 2'b00;  // Remain in state A
            end
        2'b01:  // State B
            begin
                if(in)
                    next_state = 2'b01;  // Remain in state B
                else
                    next_state = 2'b10;  // Transition to state C
            end
        2'b10:  // State C
            begin
                if(in)
                    next_state = 2'b11;  // Transition to state D
                else
                    next_state = 2'b00;  // Transition to state A
            end
        2'b11:  // State D
            begin
                if(in)
                    next_state = 2'b01;  // Transition to state B
                else
                    next_state = 2'b10;  // Transition to state C
            end
        default:  // Invalid state
            next_state = 2'b00;
    endcase
end

always_ff @(posedge clk) begin
    if(state == 2'b11)  // State D
        out = 1'b1;  // Output is high when in state D
    else
        out = 1'b0;  // Output is low for all other states
end

endmodule
