module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // Output variables
    wire [9:0] next_state;
    wire out1, out2;

    // State transition logic
    always @* begin
        case (state)
            10'b0000_0000_01: next_state = 10'b1000_0000_00;
            10'b0000_0000_10: next_state = 10'b0010_0000_00;
            10'b0000_0000_11: next_state = 10'b0000_0000_00;
            10'b1000_0000_00: next_state = 10'b0000_0000_00;
            10'b0100_0000_00: next_state = 10'b0000_0000_00;
            10'b0010_0000_00: next_state = 10'b0000_0000_00;
            10'b0001_0000_00: next_state = 10'b0000_0000_00;
            10'b0000_1000_00: next_state = 10'b0000_0000_00;
            10'b0000_0100_00: next_state = 10'b0000_0000_00;
            10'b0000_0010_00: next_state = 10'b0000_0000_00;
            default: next_state = 10'b0000_0000_00;
        endcase
    end

    // Output logic
    assign out1 = (state == 10'b0000_0000_11);
    assign out2 = (state == 10'b0000_0000_11 || state == 10'b0001_0000_00 ||
                  state == 10'b0000_0100_00 || state == 10'b0000_0010_00);

endmodule
