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

    case (state)
        10'b0000000001: // S0
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
            end else begin
                next_state = 10'b0000000010; // S1
            end

        10'b0000000010: // S1
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
            end else begin
                next_state = 10'b0000000100; // S2
            end

        10'b0000000100: // S2
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
            end else begin
                next_state = 10'b0000001000; // S3
            end

        10'b0000001000: // S3
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
            end else begin
                next_state = 10'b0000010000; // S4
            end

        10'b0000010000: // S4
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
            end else begin
                next_state = 10'b0000100000; // S5
            end

        10'b0000100000: // S5
            if (in == 0) begin
                next_state = 10'b1000000000; // S8
                out1 = 1;
            end else begin
                next_state = 10'b0001000000; // S6
            end

        10'b0001000000: // S6
            if (in == 0) begin
                next_state = 10'b0010000000; // S9
                out1 = 1;
                out2 = 1;
            end else begin
                next_state = 10'b0000000100; // S7
            end

        10'b0000000100: // S7
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
                out2 = 1;
            end else begin
                next_state = 10'b0000000100; // S7
                out2 = 1;
            end

        10'b1000000000: // S8
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
            end else begin
                next_state = 10'b0000000010; // S1
            end

        10'b0010000000: // S9
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
            end else begin
                next_state = 10'b0000000010; // S1
            end

        default:
            next_state = 10'b0000000001; // S0
    endcase
end

endmodule
