module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [4:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        5'b00000: // state A
            if (s) next_state = 5'b00001; // state B
            else next_state = state;
        5'b00001: // state B
            if (w) next_state = 5'b10000; // state S11
            else next_state = 5'b01000; // state S10
        5'b00010: // state C
            if (w) next_state = 5'b10000; // state S11
            else next_state = 5'b01000; // state S10
        5'b01000: // state S10
            if (w) next_state = 5'b10001; // state S21
            else next_state = 5'b01001; // state S20
        5'b10000: // state S11
            if (w) next_state = 5'b10010; // state S22
            else next_state = 5'b10001; // state S21
        5'b01001: // state S20
            next_state = 5'b00001; // state B
        5'b10001: // state S21
            if (w) next_state = 5'b00010; // state C
            else next_state = 5'b00001; // state B
        5'b10010: // state S22
            if (w) next_state = 5'b00001; // state B
            else next_state = 5'b00010; // state C
        default:
            next_state = 'b0;
    endcase
end

always @(state) begin
    case (state)
        5'b00000: z = 1'b0; // state A
        5'b00001: z = 1'b0; // state B
        5'b00010: z = 1'b0; // state C
        5'b01000: z = 1'b0; // state S10
        5'b01001: z = 1'b0; // state S20
        5'b10000: z = 1'b1; // state S11
        5'b10001: z = 1'b1; // state S21
        5'b10010: z = 1'b1; // state S22
        default: z = 1'b0;
    endcase
end

endmodule
