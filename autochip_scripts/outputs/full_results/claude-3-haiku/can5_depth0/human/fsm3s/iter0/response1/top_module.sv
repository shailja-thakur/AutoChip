module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= 2'b00; // State A
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        2'b00: // State A
            if (in == 1'b0)
                next_state = 2'b00; // Next state A
            else
                next_state = 2'b01; // Next state B
        2'b01: // State B
            if (in == 1'b0)
                next_state = 2'b10; // Next state C
            else
                next_state = 2'b01; // Next state B
        2'b10: // State C
            if (in == 1'b0)
                next_state = 2'b00; // Next state A
            else
                next_state = 2'b11; // Next state D
        2'b11: // State D
            if (in == 1'b0)
                next_state = 2'b10; // Next state C
            else
                next_state = 2'b01; // Next state B
    endcase
end

always @(state) begin
    case (state)
        2'b00, 2'b01, 2'b10:
            out = 1'b0;
        2'b11:
            out = 1'b1;
    endcase
end

endmodule
