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
    case (state)
        10'b0000000001: begin
            S_next = d ? 10'b0000000010 : 10'b0000000001;
            S1_next = d ? 10'b0000000010 : 10'b0000000001;
            Count_next = d ? 10'b0000000100 : 10'b0000000001;
            Wait_next = d ? 10'b0000000010 : 10'b0000000001;
            B3_next = 10'b0000000100;
        end
        
        10'b0000000010: begin
            S_next = d ? 10'b0000000010 : 10'b0000000001;
            S1_next = d ? 10'b0000000110 : 10'b0000000010;
            Count_next = d ? 10'b0000000100 : 10'b0000000001;
            Wait_next = d ? 10'b0000000110 : 10'b0000000010;
            B3_next = 10'b0000000100;
        end
        
        10'b0000000110: begin
            S_next = d ? 10'b0000000010 : 10'b0000000001;
            S1_next = d ? 10'b0000000110 : 10'b0000000010;
            Count_next = d ? 10'b0000000100 : 10'b0000000001;
            Wait_next = d ? 10'b0000001100 : 10'b0000000110;
            B3_next = 10'b0000000100;
        end
        
        10'b0000001100: begin
            S_next = d ? 10'b0000000010 : 10'b0000000001;
            S1_next = d ? 10'b0000000110 : 10'b0000000010;
            Count_next = d ? 10'b0000000100 : 10'b0000000001;
            Wait_next = d ? 10'b1000000000 : 10'b0000001100;
            B3_next = 10'b0000000100;
        end
        
        10'b1000000000: begin
            S_next = d ? 10'b0000000010 : 10'b0000000001;
            S1_next = d ? 10'b0000000110 : 10'b0000000010;
            Count_next = d ? 10'b0000000100 : 10'b0000000001;
            Wait_next = d ? 10'b1000000000 : 10'b0000001100;
            B3_next = 10'b0000000100;
        end
        
        default: begin
            S_next = 10'b0000000001;
            S1_next = 10'b0000000001;
            Count_next = 10'b0000000001;
            Wait_next = 10'b0000000001;
            B3_next = 10'b0000000001;
        end
    endcase
end


always @(*) begin
    done = state == 10'b1000000000;
    counting = state[8];
    shift_ena = state[7:5] == 3'b010;
end


endmodule
