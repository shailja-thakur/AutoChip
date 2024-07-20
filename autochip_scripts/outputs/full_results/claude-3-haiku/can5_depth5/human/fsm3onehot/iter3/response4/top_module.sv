module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

always @(*) begin
    case (state)
        4'b0001: next_state = in ? 4'b0010 : 4'b0001; // State A
        4'b0010: next_state = in ? 4'b0100 : 4'b0010; // State B
        4'b0100: next_state = in ? 4'b1000 : 4'b0001; // State C
        4'b1000: next_state = in ? 4'b0010 : 4'b0100; // State D
        default: next_state = 4'b0001; // Default to State A
    endcase
end

assign out = (state == 4'b1000); // Output is 1 when in State D, 0 otherwise

endmodule
