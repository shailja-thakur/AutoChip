module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

always @(*) begin
    out1 = 0;
    out2 = 0;
    case (state)
        10'b0000000001: // S0
            begin
                if (in) begin
                    next_state = 10'b0000000010; // S1
                end else begin
                    next_state = 10'b0000000001; // S0
                end
            end
        10'b0000000010: // S1
            begin
                if (in) begin
                    next_state = 10'b0000000100; // S2
                end else begin
                    next_state = 10'b0000000001; // S0
                end
            end
        10'b0000000100: // S2
            begin
                if (in) begin
                    next_state = 10'b0000001000; // S3
                end else begin
                    next_state = 10'b0000000001; // S0
                end
            end
        10'b0000001000: // S3
            begin
                if (in) begin
                    next_state = 10'b0000010000; // S4
                end else begin
                    next_state = 10'b0000000001; // S0
                end
            end
        10'b0000010000: // S4
            begin
                if (in) begin
                    next_state = 10'b0000100000; // S5
                end else begin
                    next_state = 10'b0000000001; // S0
                end
            end
        10'b0000100000: // S5
            begin
                if (in) begin
                    next_state = 10'b0001000000; // S6
                end else begin
                    next_state = 10'b0010000000; // S8
                    out1 = 1;
                end
            end
        10'b0001000000: // S6
            begin
                if (in) begin
                    next_state = 10'b0010000000; // S7
                    out2 = 1;
                end else begin
                    next_state = 10'b0100000000; // S9
                    out1 = 1;
                end
            end
        10'b0010000000: // S7
            begin
                if (in) begin
                    next_state = 10'b0010000000; // S7
                    out2 = 1;
                end else begin
                    next_state = 10'b0000000001; // S0
                end
            end
        10'b0010000000: // S8
            begin
                if (in) begin
                    next_state = 10'b0000000010; // S1
                end else begin
                    next_state = 10'b0000000001; // S0
                end
            end
        10'b0100000000: // S9
            begin
                if (in) begin
                    next_state = 10'b0000000010; // S1
                end else begin
                    next_state = 10'b0000000001; // S0
                end
                out1 = 1;
                out2 = 1;
            end
        default:
            begin
                next_state = 10'b0000000001; // S0
            end
    endcase
end

endmodule
