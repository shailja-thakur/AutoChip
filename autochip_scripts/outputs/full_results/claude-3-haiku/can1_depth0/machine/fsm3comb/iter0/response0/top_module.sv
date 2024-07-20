module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always_comb begin
    case (state)
        2'b00: begin // State A
            if (in) begin
                next_state = 2'b01; // Go to state B
            end else begin
                next_state = 2'b00; // Remain in state A
            end
            out = 1'b0; // Output is low in state A
        end
        2'b01: begin // State B
            if (in) begin
                next_state = 2'b01; // Remain in state B
            end else begin
                next_state = 2'b10; // Go to state C
            end
            out = 1'b0; // Output is low in state B
        end
        2'b10: begin // State C
            if (in) begin
                next_state = 2'b11; // Go to state D
            end else begin
                next_state = 2'b00; // Go to state A
            end
            out = 1'b0; // Output is low in state C
        end
        2'b11: begin // State D
            if (in) begin
                next_state = 2'b01; // Go to state B
            end else begin
                next_state = 2'b10; // Go to state C
            end
            out = 1'b1; // Output is high in state D
        end
        default: begin
            next_state = 2'b00; // Default to state A
            out = 1'b0; // Output is low in default case
        end
    endcase
end

endmodule
