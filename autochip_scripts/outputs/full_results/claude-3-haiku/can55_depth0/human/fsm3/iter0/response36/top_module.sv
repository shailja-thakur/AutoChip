module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b00; // Reset to state A
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        2'b00: // State A
            if (in == 1'b0) begin
                next_state = 2'b00; // A -> A
                out = 1'b0;
            end
            else begin
                next_state = 2'b01; // A -> B
                out = 1'b0;
            end
        2'b01: // State B
            if (in == 1'b0) begin
                next_state = 2'b10; // B -> C
                out = 1'b0;
            end
            else begin
                next_state = 2'b01; // B -> B
                out = 1'b0;
            end
        2'b10: // State C
            if (in == 1'b0) begin
                next_state = 2'b00; // C -> A
                out = 1'b0;
            end
            else begin
                next_state = 2'b11; // C -> D
                out = 1'b0;
            end
        2'b11: // State D
            if (in == 1'b0) begin
                next_state = 2'b10; // D -> C
                out = 1'b1;
            end
            else begin
                next_state = 2'b01; // D -> B
                out = 1'b1;
            end
        default:
            next_state = 2'b00; // Reset to state A
            out = 1'b0;
    endcase
end

endmodule
