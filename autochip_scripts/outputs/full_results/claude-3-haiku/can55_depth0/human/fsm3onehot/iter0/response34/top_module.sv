module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

always @(*) begin
    case (state)
        4'b0001: // State A
            if (in) begin
                next_state = 4'b0010; // B
                out = 0;
            end else begin
                next_state = 4'b0001; // A
                out = 0;
            end
        4'b0010: // State B
            if (in) begin
                next_state = 4'b0010; // B
                out = 0;
            end else begin
                next_state = 4'b0100; // C
                out = 0;
            end
        4'b0100: // State C
            if (in) begin
                next_state = 4'b1000; // D
                out = 0;
            end else begin
                next_state = 4'b0001; // A
                out = 0;
            end
        4'b1000: // State D
            if (in) begin
                next_state = 4'b0010; // B
                out = 1;
            end else begin
                next_state = 4'b0100; // C
                out = 1;
            end
        default:
            begin
                next_state = 4'b0001; // A
                out = 0;
            end
    endcase
end

endmodule
