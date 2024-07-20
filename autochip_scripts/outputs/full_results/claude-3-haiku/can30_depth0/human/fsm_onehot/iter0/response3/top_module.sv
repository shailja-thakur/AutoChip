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
    
    // State transitions
    case (1'b1)
        state[0]: begin // S0
            if (in) begin
                next_state = 10'b0000000010; // S1
            end else begin
                next_state = 10'b0000000001; // S0
            end
        end
        state[1]: begin // S1
            if (in) begin
                next_state = 10'b0000000100; // S2
            end else begin
                next_state = 10'b0000000001; // S0
            end
        end
        state[2]: begin // S2
            if (in) begin
                next_state = 10'b0000001000; // S3
            end else begin
                next_state = 10'b0000000001; // S0
            end
        end
        state[3]: begin // S3
            if (in) begin
                next_state = 10'b0000010000; // S4
            end else begin
                next_state = 10'b0000000001; // S0
            end
        end
        state[4]: begin // S4
            if (in) begin
                next_state = 10'b0000100000; // S5
            end else begin
                next_state = 10'b0000000001; // S0
            end
        end
        state[5]: begin // S5
            if (in) begin
                next_state = 10'b0001000000; // S6
            end else begin
                next_state = 10'b1000000000; // S8
            end
        end
        state[6]: begin // S6
            if (in) begin
                next_state = 10'b0010000000; // S7
            end else begin
                next_state = 10'b0100000000; // S9
            end
        end
        state[7]: begin // S7
            if (in) begin
                next_state = 10'b0010000000; // S7
            end else begin
                next_state = 10'b0000000001; // S0
            end
            out2 = 1;
        end
        state[8]: begin // S8
            if (in) begin
                next_state = 10'b0000000010; // S1
            end else begin
                next_state = 10'b0000000001; // S0
            end
            out1 = 1;
        end
        state[9]: begin // S9
            if (in) begin
                next_state = 10'b0000000010; // S1
            end else begin
                next_state = 10'b0000000001; // S0
            end
            out1 = 1;
            out2 = 1;
        end
        default: begin
            next_state = 10'b0000000001; // S0
        end
    endcase
end

endmodule
