module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

always @(*) begin
    case(state)
        // State A
        4'b0001: begin
            if (in) begin
                next_state = 4'b0010; // Transition to state B if input is 1
            end else begin
                next_state = 4'b0001; // Stay in state A if input is 0
            end
            out = 1'b0; // Output is always 0 in state A
        end
        
        // State B
        4'b0010: begin
            if (in) begin
                next_state = 4'b0010; // Stay in state B if input is 1
            end else begin
                next_state = 4'b0100; // Transition to state C if input is 0
            end
            out = 1'b0; // Output is always 0 in state B
        end
        
        // State C
        4'b0100: begin
            if (in) begin
                next_state = 4'b0001; // Transition to state A if input is 1
            end else begin
                next_state = 4'b1000; // Transition to state D if input is 0
            end
            out = 1'b0; // Output is always 0 in state C
        end
        
        // State D
        4'b1000: begin
            if (in) begin
                next_state = 4'b0100; // Transition to state C if input is 1
            end else begin
                next_state = 4'b0010; // Transition to state B if input is 0
            end
            out = 1'b1; // Output is always 1 in state D
        end
    endcase
end

endmodule
