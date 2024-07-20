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

always @* begin
    case(state)
        // State S
        2'b00:
            if(d == 0) begin
                S_next = 1;
                S1_next = 0;
                Count_next = 0;
                Wait_next = ack;
            end else begin
                S_next = 0;
                S1_next = 1;
                Count_next = 0;
                Wait_next = ack;
            end
            B3_next = 0;
        
        // State S1
        2'b01:
            if(d == 0) begin
                S_next = 0;
                S1_next = 1;
                Count_next = 0;
                Wait_next = ack;
            end else begin
                S_next = 1;
                S1_next = 0;
                Count_next = 0;
                Wait_next = ack;
            end
            B3_next = 0;
        
        // State S11
        2'b10:
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = ack;
            B3_next = 0;
        
        // State S110
        2'b11:
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = ack;
            B3_next = 0;
        
        // State B0
        10'b1_0000_0000:
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = ack;
            B3_next = 0;
        
        // State B1
        10'b0_1000_0000:
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = ack;
            B3_next = 0;
        
        // State B2
        10'b0_0100_0000:
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = ack;
            B3_next = 1;
        
        // State B3
        10'b0_0010_0000:
            S_next = 0;
            S1_next = 0;
            Count_next = 1;
            Wait_next = ack;
            B3_next = 0;
        
        // State Count
        10'b0_0001_0000:
            if(done_counting == 0) begin
                S_next = 0;
                S1_next = 0;
                Count_next = 1;
                Wait_next = ack;
                B3_next = 0;
            end else begin
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = ack;
                B3_next = 0;
            end
        
        // State Wait
        10'b0_0000_1000:
            if(ack == 1) begin
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 1;
                B3_next = 0;
            end else begin
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
                B3_next = 0;
            end
            
        default:
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 0;
    endcase
end

assign done = (state == 10'b0_0000_1000);
assign counting = (state == 10'b0_0001_0000);
assign shift_ena = (state[7:4] == 4'b0_000);

endmodule
