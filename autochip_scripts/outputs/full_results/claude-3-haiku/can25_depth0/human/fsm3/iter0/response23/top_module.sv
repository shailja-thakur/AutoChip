module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00; // state A
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        2'b00: // state A
            if (in) begin
                next_state = 2'b01; // state B
            end
            else begin
                next_state = 2'b00; // state A
            end
        2'b01: // state B
            if (in) begin
                next_state = 2'b01; // state B
            end
            else begin
                next_state = 2'b10; // state C
            end
        2'b10: // state C
            if (in) begin
                next_state = 2'b11; // state D
            end
            else begin
                next_state = 2'b00; // state A
            end
        2'b11: // state D
            if (in) begin
                next_state = 2'b01; // state B
            end
            else begin
                next_state = 2'b10; // state C
            end
        default:
            next_state = 2'b00; // state A
    endcase
end

always @(*) begin
    case (state)
        2'b00, 2'b01, 2'b10: // states A, B, C
            out = 1'b0;
        2'b11: // state D
            out = 1'b1;
        default:
            out = 1'b0;
    endcase
end

endmodule
