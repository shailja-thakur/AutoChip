module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00; // State A
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        2'b00: // State A
            if (in) begin
                next_state = 2'b01; // State B
            end
            else begin
                next_state = 2'b00; // State A
            end
        2'b01: // State B
            if (in) begin
                next_state = 2'b01; // State B
            end
            else begin
                next_state = 2'b10; // State C
            end
        2'b10: // State C
            if (in) begin
                next_state = 2'b11; // State D
            end
            else begin
                next_state = 2'b00; // State A
            end
        2'b11: // State D
            if (in) begin
                next_state = 2'b01; // State B
            end
            else begin
                next_state = 2'b10; // State C
            end
        default:
            next_state = 2'b00; // State A
    endcase

    out = (state == 2'b11); // Output is set to 1 when in State D
end

endmodule
