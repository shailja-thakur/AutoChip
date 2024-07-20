module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

// State register
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // Reset to state A
    end
    else begin
        state <= next_state;
    end
end

// Next state logic
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
        default:
            next_state = 2'b00; // Reset to state A
    endcase
end

// Output logic
always @(*) begin
    case (state)
        2'b00, 2'b01, 2'b10: // States A, B, C
            out = 1'b0;
        2'b11: // State D
            out = 1'b1;
        default:
            out = 1'b0; // Reset to output 0
    endcase
end

endmodule
