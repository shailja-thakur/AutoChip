module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

always @(*) begin
    case (state)
        4'b0001: // State A
            if (in) begin
                next_state = 4'b0010; // Next state B
            end else begin
                next_state = 4'b0001; // Next state A
            end
        4'b0010: // State B
            if (in) begin
                next_state = 4'b0010; // Next state B
            end else begin
                next_state = 4'b0100; // Next state C
            end
        4'b0100: // State C
            if (in) begin
                next_state = 4'b1000; // Next state D
            end else begin
                next_state = 4'b0001; // Next state A
            end
        4'b1000: // State D
            if (in) begin
                next_state = 4'b0010; // Next state B
            end else begin
                next_state = 4'b0100; // Next state C
            end
        default:
            next_state = 4'b0001; // Default to state A
    endcase
end

assign out = (state == 4'b1000); // Output is 1 only in state D

endmodule
