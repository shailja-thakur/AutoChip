module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state; // internal state variable

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b001; // initialize state to A
        z <= 1'b0; // initialize output to 0
    end
    else begin
        case (state)
            3'b000: // state A
                if (x) // x is high
                    state <= 3'b010; // next state B
                else
                    state <= 3'b000; // next state A
            3'b001: // state B
                if (x) // x is high
                    state <= 3'b100; // next state E
                else
                    state <= 3'b001; // next state B
            3'b010: // state C
                if (x) // x is high
                    state <= 3'b001; // next state B
                else
                    state <= 3'b010; // next state C
            3'b011: // state D
                if (x) // x is high
                    state <= 3'b010; // next state C
                else
                    state <= 3'b100; // next state B
            3'b100: // state E
                if (x) // x is high
                    state <= 3'b100; // next state E
                else
                    state <= 3'b011; // next state D
            default: // for all other states
                state <= 3'b000; // reset to state A
        endcase
    end
end

always @(state) begin
    case (state)
        3'b011, 3'b100: // states D and E
            z <= 1'b1; // set output high
        default:
            z <= 1'b0; // set output low for all other states
    endcase
end

endmodule
