module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // Combinational logic for state transition and output generation
    always @* begin
        case(state)
            10'h001 -> begin // S0
                if(in == 0) begin
                    next_state = 10'b000_000_001; // S0
                    out1 = 0;
                    out2 = 0;
                end
                else if(in == 1) begin
                    next_state = 10'b000_000_010; // S1
                    out1 = 0;
                    out2 = 0;
                end
            end

            10'h010 -> begin // S1
                if(in == 0) begin
                    next_state = 10'b000_000_001; // S0
                    out1 = 0;
                    out2 = 0;
                end
                else if(in == 1) begin
                    next_state = 10'b000_000_100; // S2
                    out1 = 0;
                    out2 = 0;
                end
            end

            10'h100 -> begin // S2
                if(in == 0) begin
                    next_state = 10'b000_000_001; // S0
                    out1 = 0;
                    out2 = 0;
                end
                else if(in == 1) begin
                    next_state = 10'b000_001_000; // S3
                    out1 = 0;
                    out2 = 0;
                end
            end

            10'h1000 -> begin // S3
                if(in == 0) begin
                    next_state = 10'b000_000_001; // S0
                    out1 = 0;
                    out2 = 0;
                end
                else if(in == 1) begin
                    next_state = 10'b000_010_000; // S4
                    out1 = 0;
                    out2 = 0;
                end
            end

            10'h10000 -> begin // S4
                if(in == 0) begin
                    next_state = 10'b000_000_001; // S0
                    out1 = 0;
                    out2 = 0;
                end
                else if(in == 1) begin
                    next_state = 10'b001_000_000; // S5
                    out1 = 0;
                    out2 = 0;
                end
            end

            10'h001_000_000 -> begin // S5
                if(in == 0) begin
                    next_state = 10'b000_000_100; // S8
                    out1 = 1;
                    out2 = 0;
                end
                else if(in == 1) begin
                    next_state = 10'b000_100_000; // S6
                    out1 = 0;
                    out2 = 0;
                end
            end

            10'h000_100_000 -> begin // S6
                if(in == 0) begin
                    next_state = 10'b000_001_001; // S9
                    out1 = 0;
                    out2 = 0;
                end
                else if(in == 1) begin
                    next_state = 10'b000_010_000; // S7
                    out1 = 0;
                    out2 = 0;
                end
            end

            10'h000_010_000 -> begin // S7
                if(in == 0) begin
                    next_state = 10'b000_000_001; // S0
                    out1 = 0;
                    out2 = 1;
                end
                else if(in == 1) begin
                    next_state = 10'b000_010_000; // S7
                    out1 = 0;
                    out2 = 1;
                end
            end

            10'h000_000_100 -> begin // S8
                if(in == 0) begin
                    next_state = 10'b000_000_001; // S0
                    out1 = 1;
                    out2 = 0;
                end
                else if(in == 1) begin
                    next_state = 10'b000_000_010; // S1
                    out1 = 0;
                    out2 = 0;
                end
            end

            10'h000_000_001 -> begin // S9
                if(in == 0) begin
                    next_state = 10'b000_000_001; // S0
                    out1 = 1;
                    out2 = 1;
                end
                else if(in == 1) begin
                    next_state = 10'b000_000_010; // S1
                    out1 = 0;
                    out2 = 0;
                end
            end

            default: begin // Invalid state
                next_state = 10'b000_000_001; // S0 (reset to initial state)
                out1 = 0;
                out2 = 0;
            end
        endcase
    end

endmodule
