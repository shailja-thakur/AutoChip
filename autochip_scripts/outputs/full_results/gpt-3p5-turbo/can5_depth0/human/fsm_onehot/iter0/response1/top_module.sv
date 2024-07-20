module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // Output and state assignments
    assign {out1, out2} = (state == 7) ? 2'b01 :
                          (state == 8) ? 2'b10 :
                          2'b00;

    always @(in, state) begin
        // State transition logic
        case (state)
            10'b0000000001: next_state = 10'b0000000001; // S0, input=0
            10'b0000000001: next_state = 10'b0000000010; // S0, input=1
            10'b0000000010: next_state = 10'b0000000001; // S1, input=0
            10'b0000000010: next_state = 10'b0000000100; // S1, input=1
            10'b0000000100: next_state = 10'b0000000001; // S2, input=0
            10'b0000000100: next_state = 10'b0000001000; // S2, input=1
            10'b0000001000: next_state = 10'b0000000001; // S3, input=0
            10'b0000001000: next_state = 10'b0000010000; // S3, input=1
            10'b0000010000: next_state = 10'b0000000001; // S4, input=0
            10'b0000010000: next_state = 10'b0000100000; // S4, input=1
            10'b0000100000: next_state = 10'b0010000000; // S5, input=0
            10'b0000100000: next_state = 10'b0001000000; // S5, input=1
            10'b0001000000: next_state = 10'b0100000000; // S6, input=0
            10'b0001000000: next_state = 10'b0010000000; // S6, input=1
            10'b0010000000: next_state = 10'b0000000001; // S7, input=0
            10'b0010000000: next_state = 10'b0010000000; // S7, input=1
            10'b0100000000: next_state = 10'b0000000001; // S8, input=0
            10'b0100000000: next_state = 10'b0000000010; // S8, input=1
            10'b1000000000: next_state = 10'b0000000001; // S9, input=0
            10'b1000000000: next_state = 10'b0000000010; // S9, input=1
            default: next_state = 10'b0; // Invalid state
        endcase
    end

endmodule
