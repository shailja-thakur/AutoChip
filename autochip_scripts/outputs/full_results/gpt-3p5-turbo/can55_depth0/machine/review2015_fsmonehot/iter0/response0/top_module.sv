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
 
    assign done = (state == 10'h800); // state Wait
    assign counting = (state == 10'h400); // state Count
    assign shift_ena = (state[3:0] != 4'b0000); // any of the states B3, B2, B1 and B0
    
    always @(*) begin
        case(state)
            10'h200: begin // state B3
                B3_next = 1'b1;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
            10'h100: begin // state B2
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
            10'h080: begin // state B1
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
            10'h040: begin // state B0
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
            10'h020: begin // state S
                B3_next = 1'b0;
                S_next = (d == 1'b0);
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
            10'h010: begin // state S1
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = (d == 1'b1);
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
            10'h018: begin // state S11
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = (d == 1'b1);
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
            10'h014: begin // state S110
                B3_next = 1'b0;
                S_next = (d == 1'b0);
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
            10'h008: begin // state Count
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = (done_counting == 1'b0) || (state == 10'h200); // done_counting is 0 or state B3 is active
                Wait_next = 1'b0;
            end
            10'h800: begin // state Wait
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = (done_counting == 1'b1) || (state == 10'h00f); // done_counting is 1 or state Wait and ack is 0
                Wait_next = (ack == 1'b1);
            end
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
