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
    next_state = 0;

    case (state)
        10'b0000000001: begin // S0
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
            end else begin
                next_state = 10'b0000000010; // S1
            end
        end
        10'b0000000010: begin // S1
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
            end else begin
                next_state = 10'b0000000100; // S2
            end
        end
        10'b0000000100: begin // S2
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
            end else begin
                next_state = 10'b0000001000; // S3
            end
        end
        10'b0000001000: begin // S3
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
            end else begin
                next_state = 10'b0000010000; // S4
            end
        end
        10'b0000010000: begin // S4
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
            end else begin
                next_state = 10'b0000100000; // S5
            end
        end
        10'b0000100000: begin // S5
            if (in == 0) begin
                next_state = 10'b1000000000; // S8
            end else begin
                next_state = 10'b0001000000; // S6
            end
        end
        10'b0001000000: begin // S6
            if (in == 0) begin
                next_state = 10'b0100000000; // S9
            end else begin
                next_state = 10'b0010000000; // S7
            end
        end
        10'b0010000000: begin // S7
            out2 = 1;
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
            end else begin
                next_state = 10'b0010000000; // S7
            end
        end
        10'b1000000000: begin // S8
            out1 = 1;
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
            end else begin
                next_state = 10'b0000000010; // S1
            end
        end
        10'b0100000000: begin // S9
            out1 = 1;
            out2 = 1;
            if (in == 0) begin
                next_state = 10'b0000000001; // S0
            end else begin
                next_state = 10'b0000000010; // S1
            end
        end
    endcase
end

endmodule
