module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // initial state is A
    else
        state <= next_state;
end

always @* begin
    case (state)
        3'b000: // state A
            if (w)
                next_state = 3'b001; // next state is B
            else
                next_state = 3'b000; // next state is A
        3'b001: // state B
            if (w)
                next_state = 3'b010; // next state is C
            else
                next_state = 3'b010; // next state is D
        3'b010: // state C
            if (w)
                next_state = 3'b100; // next state is E
            else
                next_state = 3'b010; // next state is D
        3'b011: // state D
            if (w)
                next_state = 3'b111; // next state is F
            else
                next_state = 3'b000; // next state is A
        3'b100: // state E
            if (w)
                next_state = 3'b100; // next state is E
            else
                next_state = 3'b010; // next state is D
        3'b101: // state F
            if (w)
                next_state = 3'b011; // next state is C
            else
                next_state = 3'b010; // next state is D
        default:
            next_state = 3'b000; // default next state is A
    endcase
end

assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;

endmodule
