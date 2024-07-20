module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

always @(*) begin
    // Default outputs
    out1 = 0;
    out2 = 0;
    
    // State transition logic
    case (1'b1)
        state[0]: begin
            next_state[0] = in ? state[1] : state[0];
            next_state[1:9] = 0;
        end
        state[1]: begin
            next_state[0] = in ? state[2] : state[0];
            next_state[1] = ~in;
            next_state[2:9] = 0;
        end
        state[2]: begin
            next_state[0] = in ? state[3] : state[0];
            next_state[2] = ~in;
            next_state[3:9] = 0;
        end
        state[3]: begin
            next_state[0] = in ? state[4] : state[0];
            next_state[3] = ~in;
            next_state[4:9] = 0;
        end
        state[4]: begin
            next_state[0] = in ? state[5] : state[0];
            next_state[4] = ~in;
            next_state[5:9] = 0;
        end
        state[5]: begin
            next_state[0] = in ? state[6] : state[8];
            next_state[5] = ~in;
            next_state[6:7] = 0;
            next_state[8:9] = 0;
        end
        state[6]: begin
            next_state[0] = in ? state[7] : state[9];
            next_state[6] = ~in;
            next_state[7:9] = 0;
        end
        state[7]: begin
            next_state[0] = in ? state[7] : state[0];
            next_state[7] = ~in;
            out2 = 1;
        end
        state[8]: begin
            next_state[0] = in ? state[1] : state[0];
            next_state[8] = ~in;
            out1 = 1;
        end
        state[9]: begin
            next_state[0] = in ? state[1] : state[0];
            next_state[9] = ~in;
            out1 = 1;
            out2 = 1;
        end
        default: begin
            next_state = 0;
        end
    endcase
end

endmodule
