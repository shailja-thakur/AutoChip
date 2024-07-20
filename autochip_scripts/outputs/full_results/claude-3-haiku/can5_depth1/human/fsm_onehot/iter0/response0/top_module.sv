module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

always @(*) begin
    // Default outputs
    out1 = 1'b0;
    out2 = 1'b0;

    // State transition logic
    case (1'b1)
        state[0]: begin
            next_state[0] = ~in;
            next_state[1] = in;
        end
        state[1]: begin
            next_state[0] = ~in;
            next_state[2] = in;
        end
        state[2]: begin
            next_state[0] = ~in;
            next_state[3] = in;
        end
        state[3]: begin
            next_state[0] = ~in;
            next_state[4] = in;
        end
        state[4]: begin
            next_state[0] = ~in;
            next_state[5] = in;
        end
        state[5]: begin
            next_state[0] = ~in;
            next_state[6] = in;
            next_state[8] = 1'b0;
            next_state[9] = 1'b0;
        end
        state[6]: begin
            next_state[0] = ~in;
            next_state[7] = in;
        end
        state[7]: begin
            next_state[0] = ~in;
            out2 = 1'b1;
        end
        state[8]: begin
            next_state[0] = ~in;
            next_state[1] = in;
            out1 = 1'b1;
        end
        state[9]: begin
            next_state[0] = ~in;
            next_state[1] = in;
            out1 = 1'b1;
            out2 = 1'b1;
        end
    endcase
end

endmodule
