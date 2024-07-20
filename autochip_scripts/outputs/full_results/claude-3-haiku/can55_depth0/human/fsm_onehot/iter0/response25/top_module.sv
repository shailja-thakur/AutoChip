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
    case (1'b1) // One-hot encoding
        state[0]: // S0
            if (in) begin
                next_state = 10'b0000000010; // S1
            end else begin
                next_state = 10'b1000000000; // S0
            end
        state[1]: // S1
            if (in) begin
                next_state = 10'b0000000100; // S2
            end else begin
                next_state = 10'b1000000000; // S0
            end
        state[2]: // S2
            if (in) begin
                next_state = 10'b0000001000; // S3
            end else begin
                next_state = 10'b1000000000; // S0
            end
        state[3]: // S3
            if (in) begin
                next_state = 10'b0000010000; // S4
            end else begin
                next_state = 10'b1000000000; // S0
            end
        state[4]: // S4
            if (in) begin
                next_state = 10'b0000100000; // S5
            end else begin
                next_state = 10'b1000000000; // S0
            end
        state[5]: // S5
            if (in) begin
                next_state = 10'b0001000000; // S6
            end else begin
                next_state = 10'b0010000000; // S8
            end
        state[6]: // S6
            if (in) begin
                next_state = 10'b0010000000; // S7
            end else begin
                next_state = 10'b0100000000; // S9
            end
        state[7]: // S7
            if (in) begin
                next_state = 10'b0010000000; // S7
            end else begin
                next_state = 10'b1000000000; // S0
            end
            out2 = 1'b1;
        state[8]: // S8
            if (in) begin
                next_state = 10'b0000000010; // S1
            end else begin
                next_state = 10'b1000000000; // S0
            end
            out1 = 1'b1;
        state[9]: // S9
            if (in) begin
                next_state = 10'b0000000010; // S1
            end else begin
                next_state = 10'b1000000000; // S0
            end
            out1 = 1'b1;
            out2 = 1'b1;
        default:
            next_state = 10'b1000000000; // S0
    endcase
end

endmodule
