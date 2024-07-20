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
                next_state = 4'b0010; // A -> B
            end else begin
                next_state = 4'b0001; // A -> A
            end
        4'b0010: // State B
            if (in) begin
                next_state = 4'b0010; // B -> B
            end else begin
                next_state = 4'b0100; // B -> C
            end
        4'b0100: // State C
            if (in) begin
                next_state = 4'b1000; // C -> D
            end else begin
                next_state = 4'b0001; // C -> A
            end
        4'b1000: // State D
            if (in) begin
                next_state = 4'b0010; // D -> B
            end else begin
                next_state = 4'b0100; // D -> C
            end
        default:
            next_state = 4'b0001; // Default to State A
    endcase
end

assign out = (state == 4'b1000); // Output is 1 when in State D, 0 otherwise

endmodule
