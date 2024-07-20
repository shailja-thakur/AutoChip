module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

always @(*) begin
    next_state = 10'b0;
    out1 = 0;
    out2 = 0;

    case (1'b1)
        state[0]: begin
            if (in) begin
                next_state[1] = 1;
            end else begin
                next_state[0] = 1;
            end
        end
        state[1]: begin
            if (in) begin
                next_state[2] = 1;
            end else begin
                next_state[0] = 1;
            end
        end
        state[2]: begin
            if (in) begin
                next_state[3] = 1;
            end else begin
                next_state[0] = 1;
            end
        end
        state[3]: begin
            if (in) begin
                next_state[4] = 1;
            end else begin
                next_state[0] = 1;
            end
        end
        state[4]: begin
            if (in) begin
                next_state[5] = 1;
            end else begin
                next_state[0] = 1;
            end
        end
        state[5]: begin
            if (in) begin
                next_state[6] = 1;
            end else begin
                next_state[0] = 1;
            end
        end
        state[6]: begin
            if (in) begin
                next_state[7] = 1;
            end else begin
                next_state[0] = 1;
            end
        end
        state[7]: begin
            out2 = 1;
            if (in) begin
                next_state[7] = 1;
            end else begin
                next_state[0] = 1;
            end
        end
        state[8]: begin
            out1 = 1;
            if (in) begin
                next_state[1] = 1;
            end else begin
                next_state[0] = 1;
            end
        end
        state[9]: begin
            out1 = 1;
            out2 = 1;
            if (in) begin
                next_state[1] = 1;
            end else begin
                next_state[0] = 1;
            end
        end
    endcase
end

endmodule
