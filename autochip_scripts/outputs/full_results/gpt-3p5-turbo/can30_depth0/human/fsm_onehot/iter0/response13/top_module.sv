module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    reg [9:0] next_state;
    reg out1, out2;

    always @* begin
        case (state)
            10'b000_000_000: begin // S0
                if (in == 1) begin
                    next_state = 10'b000_000_001; // S1
                end else begin
                    next_state = 10'b000_000_000; // S0
                end
                out1 = 0;
                out2 = 0;
            end
            10'b000_000_001: begin // S1
                if (in == 1) begin
                    next_state = 10'b000_000_010; // S2
                end else begin
                    next_state = 10'b000_000_000; // S0
                end
                out1 = 0;
                out2 = 0;
            end
            10'b000_000_010: begin // S2
                if (in == 1) begin
                    next_state = 10'b000_000_011; // S3
                end else begin
                    next_state = 10'b000_000_000; // S0
                end
                out1 = 0;
                out2 = 0;
            end
            10'b000_000_011: begin // S3
                if (in == 1) begin
                    next_state = 10'b000_000_100; // S4
                end else begin
                    next_state = 10'b000_000_000; // S0
                end
                out1 = 0;
                out2 = 0;
            end
            10'b000_000_100: begin // S4
                if (in == 1) begin
                    next_state = 10'b000_000_101; // S5
                end else begin
                    next_state = 10'b000_000_000; // S0
                end
                out1 = 0;
                out2 = 0;
            end
            10'b000_000_101: begin // S5
                if (in == 1) begin
                    next_state = 10'b000_001_000; // S8
                end else begin
                    next_state = 10'b000_000_110; // S6
                end
                out1 = 0;
                out2 = 0;
            end
            10'b000_000_110: begin // S6
                if (in == 1) begin
                    next_state = 10'b000_001_001; // S9
                end else begin
                    next_state = 10'b000_000_111; // S7
                end
                out1 = 0;
                out2 = 0;
            end
            10'b000_000_111: begin // S7
                if (in == 1) begin
                    next_state = 10'b000_000_000; // S0
                end else begin
                    next_state = 10'b000_000_111; // S7
                end
                out1 = 0;
                out2 = 1;
            end
            10'b000_001_000: begin // S8
                if (in == 1) begin
                    next_state = 10'b000_000_001; // S1
                end else begin
                    next_state = 10'b000_000_000; // S0
                end
                out1 = 1;
                out2 = 0;
            end
            10'b000_001_001: begin // S9
                if (in == 1) begin
                    next_state = 10'b000_000_001; // S1
                end else begin
                    next_state = 10'b000_000_000; // S0
                end
                out1 = 1;
                out2 = 1;
            end
            default: begin
                next_state = 10'b000_000_000; // S0
                out1 = 0;
                out2 = 0;
            end
        endcase
    end

endmodule
