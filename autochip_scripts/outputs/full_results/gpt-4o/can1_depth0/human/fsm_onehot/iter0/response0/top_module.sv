module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    reg [9:0] next_state_reg;
    reg out1_reg;
    reg out2_reg;

    always @(*) begin
        // Default outputs
        out1_reg = 0;
        out2_reg = 0;

        // Default next_state
        next_state_reg = 10'b0000000000;

        case (state)
            10'b0000000001: next_state_reg = in ? 10'b0000000010 : 10'b0000000001; // S0
            10'b0000000010: next_state_reg = in ? 10'b0000000100 : 10'b0000000001; // S1
            10'b0000000100: next_state_reg = in ? 10'b0000001000 : 10'b0000000001; // S2
            10'b0000001000: next_state_reg = in ? 10'b0000010000 : 10'b0000000001; // S3
            10'b0000010000: next_state_reg = in ? 10'b0000100000 : 10'b0000000001; // S4
            10'b0000100000: next_state_reg = in ? 10'b0001000000 : 10'b1000000000; // S5
            10'b0001000000: next_state_reg = in ? 10'b0010000000 : 10'b0100000000; // S6
            10'b0010000000: next_state_reg = in ? 10'b0010000000 : 10'b0000000001; // S7
            10'b0100000000: next_state_reg = in ? 10'b0000000010 : 10'b0000000001; // S8
            10'b1000000000: next_state_reg = in ? 10'b0000000010 : 10'b0000000001; // S9
            default: next_state_reg = 10'b0000000001; // Default to S0
        endcase

        // Output logic based on states
        if (state == 10'b0010000000) begin // S7
            out2_reg = 1;
        end
        if (state == 10'b0100000000) begin // S8
            out1_reg = 1;
        end
        if (state == 10'b1000000000) begin // S9
            out1_reg = 1;
            out2_reg = 1;
        end
    end

    assign next_state = next_state_reg;
    assign out1 = out1_reg;
    assign out2 = out2_reg;

endmodule
