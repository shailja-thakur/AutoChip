module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always @(*) begin
    case (state)
        2'b00: // State A
            if (in == 0) begin
                next_state = 2'b00; // A
                out = 0;
            end else begin
                next_state = 2'b01; // B
                out = 0;
            end
        2'b01: // State B
            if (in == 0) begin
                next_state = 2'b10; // C
                out = 0;
            end else begin
                next_state = 2'b01; // B
                out = 0;
            end
        2'b10: // State C
            if (in == 0) begin
                next_state = 2'b00; // A
                out = 0;
            end else begin
                next_state = 2'b11; // D
                out = 0;
            end
        2'b11: // State D
            if (in == 0) begin
                next_state = 2'b10; // C
                out = 1;
            end else begin
                next_state = 2'b01; // B
                out = 1;
            end
    endcase
end

endmodule
