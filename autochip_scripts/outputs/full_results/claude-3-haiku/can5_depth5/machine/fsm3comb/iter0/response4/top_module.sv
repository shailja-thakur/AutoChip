module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always_comb begin
    case (state)
        2'd0: // State A
            if (in) begin
                next_state = 2'd1; // Go to state B
            end else begin
                next_state = 2'd0; // Remain in state A
            end
        2'd1: // State B
            if (in) begin
                next_state = 2'd1; // Remain in state B
            end else begin
                next_state = 2'd2; // Go to state C
            end
        2'd2: // State C
            if (in) begin
                next_state = 2'd3; // Go to state D
            end else begin
                next_state = 2'd0; // Go to state A
            end
        2'd3: // State D
            if (in) begin
                next_state = 2'd1; // Go to state B
            end else begin
                next_state = 2'd2; // Go to state C
            end
        default:
            next_state = 2'd0; // Default to state A
    endcase

    out = (state == 2'd3); // Set 'out' high when in state D
end

endmodule
