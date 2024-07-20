module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state, next_state;
reg out_reg;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00; // Reset to state A
    else
        state <= next_state;
end

always @* begin
    // State transition logic
    case (state)
        2'b00:
            if (in)
                next_state = 2'b01; // Next state B
            else
                next_state = 2'b00; // Next state A
        2'b01:
            if (in)
                next_state = 2'b01; // Next state B
            else
                next_state = 2'b10; // Next state C
        2'b10:
            if (in)
                next_state = 2'b11; // Next state D
            else
                next_state = 2'b00; // Next state A
        2'b11:
            if (in)
                next_state = 2'b01; // Next state B
            else
                next_state = 2'b10; // Next state C
    endcase

    // Output logic
    case (state)
        2'b00: out_reg = 1'b0; // Output 0
        2'b01: out_reg = 1'b0; // Output 0
        2'b10: out_reg = 1'b0; // Output 0
        2'b11: out_reg = 1'b1; // Output 1
    endcase
end

always @(posedge clk) begin
    out <= out_reg;
end

endmodule
