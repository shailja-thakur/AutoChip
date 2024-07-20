module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

always @(*) begin
    next_state = 10'b0;
    out1 = 1'b0;
    out2 = 1'b0;

    case (1'b1)
        state[0]: begin // S0
            if (in == 1'b0) begin
                next_state[0] = 1'b1;
            end else begin
                next_state[1] = 1'b1;
            end
        end
        state[1]: begin // S1
            if (in == 1'b0) begin
                next_state[0] = 1'b1;
            end else begin
                next_state[2] = 1'b1;
            end
        end
        state[2]: begin // S2
            if (in == 1'b0) begin
                next_state[0] = 1'b1;
            end else begin
                next_state[3] = 1'b1;
            end
        end
        state[3]: begin // S3
            if (in == 1'b0) begin
                next_state[0] = 1'b1;
            end else begin
                next_state[4] = 1'b1;
            end
        end
        state[4]: begin // S4
            if (in == 1'b0) begin
                next_state[0] = 1'b1;
            end else begin
                next_state[5] = 1'b1;
            end
        end
        state[5]: begin // S5
            if (in == 1'b0) begin
                next_state[8] = 1'b1;
            end else begin
                next_state[6] = 1'b1;
            end
        end
        state[6]: begin // S6
            if (in == 1'b0) begin
                next_state[9] = 1'b1;
            end else begin
                next_state[7] = 1'b1;
            end
        end
        state[7]: begin // S7
            if (in == 1'b0) begin
                next_state[0] = 1'b1;
                out2 = 1'b1;
            end else begin
                next_state[7] = 1'b1;
                out2 = 1'b1;
            end
        end
        state[8]: begin // S8
            if (in == 1'b0) begin
                next_state[0] = 1'b1;
                out1 = 1'b1;
            end else begin
                next_state[1] = 1'b1;
                out1 = 1'b1;
            end
        end
        state[9]: begin // S9
            if (in == 1'b0) begin
                next_state[0] = 1'b1;
                out1 = 1'b1;
                out2 = 1'b1;
            end else begin
                next_state[1] = 1'b1;
                out1 = 1'b1;
                out2 = 1'b1;
            end
        end
    endcase
end

endmodule
