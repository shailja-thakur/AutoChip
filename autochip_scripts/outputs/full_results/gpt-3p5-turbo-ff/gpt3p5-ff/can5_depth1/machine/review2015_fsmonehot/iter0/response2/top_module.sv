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
        S: begin
            if (d == 0) begin
                S_next = 1'b1;
                S1_next = 1'b0;
            end
            else begin
                S_next = 1'b0;
                S1_next = 1'b1;
            end
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        
        S1: begin
            if (d == 0) begin
                S_next = 1'b0;
                S1_next = 1'b1;
            end
            else begin
                S_next = 1'b1;
                S1_next = 1'b0;
            end
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        
        S11: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        
        S110: begin
            if (d == 0) begin
                S_next = 1'b1;
                S1_next = 1'b0;
            end
            else begin
                S_next = 1'b0;
                S1_next = 1'b1;
            end
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        
        B0: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        
        B1: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        
        B2: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b1;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        
        B3: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        
        Count: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b1;
            Wait_next = 1'b0;
        end
        
        Wait: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b1;
        end
    endcase
 end
 
 assign shift_ena = (state[B3] || state[B2] || state[B1] || state[B0]);
 assign done = (state == Wait);
 assign counting = (state == Count);
 
 endmodule
