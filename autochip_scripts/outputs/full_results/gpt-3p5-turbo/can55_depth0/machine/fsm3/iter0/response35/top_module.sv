module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00; // Reset state to A
        out <= 0;
    end else begin
        state <= next_state;
        if (state == 2'b11) // State D
            out <= 1;
        else
            out <= 0;
    end
end

always @(state or in) begin
    case (state)
        2'b00: // State A
            if (in)
                next_state = 2'b01; // Next state B
            else
                next_state = 2'b00; // Next state A
        2'b01: // State B
            if (in)
                next_state = 2'b01; // Next state B
            else
                next_state = 2'b10; // Next state C
        2'b10: // State C
            if (in)
                next_state = 2'b11; // Next state D
            else
                next_state = 2'b00; // Next state A
        2'b11: // State D
            if (in)
                next_state = 2'b01; // Next state B
            else
                next_state = 2'b10; // Next state C
    endcase
end

endmodule
