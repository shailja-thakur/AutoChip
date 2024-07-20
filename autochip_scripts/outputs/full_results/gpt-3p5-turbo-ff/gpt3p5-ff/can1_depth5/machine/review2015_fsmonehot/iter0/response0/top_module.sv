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

always @(*) begin
    assign done = (state == 10'd9);
    assign counting = (state == 10'd8);
    assign shift_ena = (state[3] || state[2] || state[1] || state[0]);
    
    case (state)
        10'd0: begin
            B3_next = 1'b0;
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'd1: begin
            B3_next = 1'b0;
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'd2: begin
            B3_next = 1'b0;
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'd3: begin
            B3_next = 1'b0;
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'd4: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'd5: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'd6: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'd7: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = (ack == 1'b1);
        end
        10'd8: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = (done_counting == 1'b0);
            Wait_next = (ack == 1'b0);
        end
        10'd9: begin
            B3_next = 1'b1;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
    endcase
end

endmodule
