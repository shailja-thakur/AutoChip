module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

always @(*) begin
    case (state)
        4'b0001: // State A
            if (in == 0) begin
                next_state = 4'b0001; // A
            end else begin
                next_state = 4'b0010; // B
            end
        4'b0010: // State B
            if (in == 0) begin
                next_state = 4'b0100; // C
            end else begin
                next_state = 4'b0010; // B
            end
        4'b0100: // State C
            if (in == 0) begin
                next_state = 4'b0001; // A
            end else begin
                next_state = 4'b1000; // D
            end
        4'b1000: // State D
            if (in == 0) begin
                next_state = 4'b0100; // C
            end else begin
                next_state = 4'b0010; // B
            end
        default:
            next_state = 4'b0001; // A
    endcase
end

assign out = (state == 4'b1000) ? 1 : 0; // State D outputs 1, all other states output 0

endmodule
