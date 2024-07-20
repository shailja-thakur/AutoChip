module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

always @(posedge clk, posedge reset) begin
    if (reset)
        state <= 2'b00; // State A
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        2'b00: // State A
            if (in == 1'b0)
                next_state = 2'b00; // A->A
            else
                next_state = 2'b01; // A->B
        2'b01: // State B
            if (in == 1'b0)
                next_state = 2'b10; // B->C
            else
                next_state = 2'b01; // B->B
        2'b10: // State C
            if (in == 1'b0)
                next_state = 2'b00; // C->A
            else
                next_state = 2'b11; // C->D
        2'b11: // State D
            if (in == 1'b0)
                next_state = 2'b10; // D->C
            else
                next_state = 2'b01; // D->B
    endcase
end

always @(state) begin
    case (state)
        2'b00, 2'b01, 2'b10: out = 1'b0; // A, B, C
        2'b11: out = 1'b1; // D
    endcase
end

endmodule
