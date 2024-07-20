module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk, posedge reset) begin
    if (reset)
        state <= 'b0;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        'b000: // state A
            if (s)
                next_state = 'b001; // state B
            else
                next_state = state;
        'b001: // state B
            if (w)
                next_state = 'b010; // state S11
            else
                next_state = 'b011; // state S10
        'b010: // state S11
            if (w)
                next_state = 'b100; // state S22
            else
                next_state = 'b011; // state S21
        'b011: // state S10
            if (w)
                next_state = 'b101; // state S21
            else
                next_state = 'b110; // state S20
        'b100: // state S22
            if (w)
                next_state = 'b001; // state B
            else
                next_state = 'b010; // state C
        'b101: // state S21
            if (w)
                next_state = 'b010; // state C
            else
                next_state = 'b001; // state B
        'b110: // state S20
            next_state = 'b001; // state B
        default:
            next_state = 'b000; // state A
    endcase
end

always @(state) begin
    case (state)
        'b010, 'b100:
            z = 1'b1;
        default:
            z = 1'b0;
    endcase
end

endmodule
