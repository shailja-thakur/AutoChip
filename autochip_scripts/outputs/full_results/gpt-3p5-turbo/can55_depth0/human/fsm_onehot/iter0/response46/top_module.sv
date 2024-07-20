module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // Next state logic
    always @* begin
        case (state)
            10'b0000000001: next_state = 10'b1000000000;
            10'b0000000000: next_state = in ? 10'b0000000010 : 10'b0000000001;
            10'b1000000000: next_state = in ? 10'b0000000001 : 10'b0000000000;
            10'b0000000010: next_state = in ? 10'b0000000011 : 10'b0000000001;
            10'b0000000011: next_state = in ? 10'b0000000100 : 10'b0000000001;
            10'b0000000100: next_state = in ? 10'b0000000101 : 10'b0000000001;
            10'b0000000101: next_state = in ? 10'b0000001000 : 10'b0000000000;
            10'b0000001000: next_state = in ? 10'b0000000001 : 10'b0000000010;
            10'b0000001001: next_state = in ? 10'b0000000001 : 10'b0000000000;
            10'b0000001010: next_state = in ? 10'b0000000010 : 10'b0000000000;
            default: next_state = 10'bxxxxxxxxxx; // Invalid state, pass-through
        endcase
    end

    // Output logic
    assign out1 = (state == 10'b0000000110) ? 1'b1 : 1'b0;
    assign out2 = (state == 10'b0000000111) ? 1'b1 : 1'b0;

endmodule
