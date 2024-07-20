module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
 );

    // Assign default values to outputs
    assign done = (state == 9'b1111111110) ? 1'b1 : 1'b0;
    assign counting = (state == 9'b0000001100) ? 1'b1 : 1'b0;
    assign shift_ena = (state[3:0] != 4'b0000) ? 1'b1 : 1'b0;

    always @(*) begin
        case(state)
            9'b0000000001: B3_next = 1'b1;
            9'b0000000000: S_next = (d == 1'b0) ? 1'b1 : 1'b0;
            9'b0000000010: S1_next = (d == 1'b1) ? 1'b1 : 1'b0;
            9'b0000001100: Count_next = (state == 9'b0000001010 || done_counting == 1'b0) ? 1'b1 : 1'b0;
            9'b0000001101: Wait_next = (state == 9'b0000001100 && done_counting == 1'b1) ? 1'b1 : 1'b0;
            default: begin
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
        endcase
    end
    
endmodule
