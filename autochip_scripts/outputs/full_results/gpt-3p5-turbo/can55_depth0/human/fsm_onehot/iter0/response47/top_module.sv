module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
 
    // State transition logic
    always @* begin
        case (state)
            // S0 (0, 0)
            10'b0000000001:
                if (in == 1'b0) begin
                    next_state = 10'b0000000001; // S0 (0, 0)
                end else begin
                    next_state = 10'b0000000010; // S1 (0, 0)
                end
            // S1 (0, 0)
            10'b0000000010:
                if (in == 1'b0) begin
                    next_state = 10'b0000000001; // S0 (0, 0)
                end else begin
                    next_state = 10'b0000000011; // S2 (0, 0)
                end
            // S2 (0, 0)
            10'b0000000011:
                if (in == 1'b0) begin
                    next_state = 10'b0000000001; // S0 (0, 0)
                end else begin
                    next_state = 10'b0000000100; // S3 (0, 0)
                end
            // S3 (0, 0)
            10'b0000000100:
                if (in == 1'b0) begin
                    next_state = 10'b0000000001; // S0 (0, 0)
                end else begin
                    next_state = 10'b0000000101; // S4 (0, 0)
                end
            // S4 (0, 0)
            10'b0000000101:
                if (in == 1'b0) begin
                    next_state = 10'b0000000001; // S0 (0, 0)
                end else begin
                    next_state = 10'b0000000110; // S5 (0, 0)
                end
            // S5 (0, 0)
            10'b0000000110:
                if (in == 1'b0) begin
                    next_state = 10'b0000001000; // S8 (1, 0)
                end else begin
                    next_state = 10'b0000000111; // S6 (0, 0)
                end
            // S6 (0, 0)
            10'b0000000111:
                if (in == 1'b0) begin
                    next_state = 10'b0000001001; // S9 (1, 1)
                end else begin
                    next_state = 10'b0000001000; // S8 (1, 0)
                end
            // S7 (0, 1)
            10'b0000001000:
                if (in == 1'b0) begin
                    next_state = 10'b0000000001; // S0 (0, 0)
                end else begin
                    next_state = 10'b0000001000; // S7 (0, 1)
                end
            // S8 (1, 0)
            10'b0000001001:
                if (in == 1'b0) begin
                    next_state = 10'b0000000001; // S0 (0, 0)
                end else begin
                    next_state = 10'b0000000010; // S1 (0, 0)
                end
            // S9 (1, 1)
            10'b0000001010:
                if (in == 1'b0) begin
                    next_state = 10'b0000000001; // S0 (0, 0)
                end else begin
                    next_state = 10'b0000000010; // S1 (0, 0)
                end
        endcase
    end
 
    // Output logic
    assign out1 = (state == 10'b0000000110) ? 1'b1 : 1'b0;
    assign out2 = (state == 10'b0000001000) ? 1'b1 : 1'b0;
 
endmodule
