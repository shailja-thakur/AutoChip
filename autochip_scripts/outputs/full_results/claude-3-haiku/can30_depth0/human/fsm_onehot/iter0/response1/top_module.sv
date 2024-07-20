module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

always @(*) begin
    // State transition logic
    case (1'b1)
        state[0]: next_state = (in) ? state[1] : state[0];
        state[1]: next_state = (in) ? state[2] : state[0];
        state[2]: next_state = (in) ? state[3] : state[0];
        state[3]: next_state = (in) ? state[4] : state[0];
        state[4]: next_state = (in) ? state[5] : state[0];
        state[5]: next_state = (in) ? state[6] : state[8];
        state[6]: next_state = (in) ? state[7] : state[9];
        state[7]: next_state = (in) ? state[7] : state[0];
        state[8]: next_state = (in) ? state[1] : state[0];
        state[9]: next_state = (in) ? state[1] : state[0];
        default: next_state = 10'b0;
    endcase

    // Output logic
    case (1'b1)
        state[7]: begin out1 = 0; out2 = 1; end
        state[8]: begin out1 = 1; out2 = 0; end
        state[9]: begin out1 = 1; out2 = 1; end
        default: begin out1 = 0; out2 = 0; end
    endcase
end

endmodule
