module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always_comb begin
    case (state)
        2'b00: // State A
            if (in) begin
                next_state = 2'b01; // State B
            end else begin
                next_state = 2'b00; // State A
            end
        2'b01: // State B
            if (in) begin
                next_state = 2'b01; // State B
            end else begin
                next_state = 2'b10; // State C
            end
        2'b10: // State C
            if (in) begin
                next_state = 2'b11; // State D
            end else begin
                next_state = 2'b00; // State A
            end
        2'b11: // State D
            if (in) begin
                next_state = 2'b01; // State B
            end else begin
                next_state = 2'b10; // State C
            end
        default:
            next_state = 2'b00; // State A
    endcase

    out = (state == 2'b11); // Output high when in State D
end

endmodule
