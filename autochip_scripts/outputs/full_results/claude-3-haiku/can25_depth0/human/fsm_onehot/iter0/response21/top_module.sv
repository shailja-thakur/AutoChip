module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

always @(*) begin
    // Default outputs to 0
    out1 = 0;
    out2 = 0;

    // State transition logic
    case (1'b1)
        state[0]: begin
            next_state = (in) ? state[1] : state[0];
        end
        state[1]: begin
            next_state = (in) ? state[2] : state[0];
        end
        state[2]: begin
            next_state = (in) ? state[3] : state[0];
        end
        state[3]: begin
            next_state = (in) ? state[4] : state[0];
        end
        state[4]: begin
            next_state = (in) ? state[5] : state[0];
        end
        state[5]: begin
            next_state = (in) ? state[6] : state[8];
        end
        state[6]: begin
            next_state = (in) ? state[7] : state[9];
        end
        state[7]: begin
            out2 = 1;
            next_state = (in) ? state[7] : state[0];
        end
        state[8]: begin
            out1 = 1;
            next_state = (in) ? state[1] : state[0];
        end
        state[9]: begin
            out1 = 1;
            out2 = 1;
            next_state = (in) ? state[1] : state[0];
        end
    endcase
end

endmodule
