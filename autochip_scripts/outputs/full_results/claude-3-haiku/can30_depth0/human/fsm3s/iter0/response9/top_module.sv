module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        2'b00: // State A
            if (in == 0)
                next_state = 2'b00; // A
            else
                next_state = 2'b01; // B
        2'b01: // State B
            if (in == 0)
                next_state = 2'b10; // C
            else
                next_state = 2'b01; // B
        2'b10: // State C
            if (in == 0)
                next_state = 2'b00; // A
            else
                next_state = 2'b11; // D
        2'b11: // State D
            if (in == 0)
                next_state = 2'b10; // C
            else
                next_state = 2'b01; // B
    endcase
end

// Output logic
always @(*) begin
    case (state)
        2'b00, 2'b01, 2'b10: // A, B, C
            out = 0;
        2'b11: // D
            out = 1;
    endcase
end

// State register
always @(posedge clk, posedge reset) begin
    if (reset)
        state <= 2'b00; // Reset to state A
    else
        state <= next_state;
end

endmodule
