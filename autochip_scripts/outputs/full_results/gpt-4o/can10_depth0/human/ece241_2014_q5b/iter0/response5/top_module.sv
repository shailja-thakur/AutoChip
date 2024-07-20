module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

    // State encoding using one-hot
    reg state_A, state_B;
    
    // Sequential logic for state transitions
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to state A
            state_A <= 1'b1;
            state_B <= 1'b0;
        end else begin
            case ({state_A, state_B})
                2'b10: begin // State A
                    if (x) begin
                        state_A <= 1'b0;
                        state_B <= 1'b1;
                    end
                    // else remain in state A
                end
                2'b01: begin // State B
                    if (~x) begin
                        // Remain in state B
                        state_A <= 1'b0;
                        state_B <= 1'b1;
                    end
                    // else remain in state B
                end
                default: begin
                    // In case of an invalid state, reset to A
                    state_A <= 1'b1;
                    state_B <= 1'b0;
                end
            endcase
        end
    end

    // Combinational logic for output z
    always @(*) begin
        case({state_A, state_B})
            2'b10: z = x; // State A
            2'b01: z = ~x; // State B
            default: z = 1'b0; // Default state, should not happen
        endcase
    end
endmodule
