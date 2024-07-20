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

 // State declarations
 parameter S = 1'b0;
 parameter S1 = 1'b1;
 parameter S11 = 1'b2;
 parameter S110 = 1'b3;
 parameter B0 = 1'b4;
 parameter B1 = 1'b5;
 parameter B2 = 1'b6;
 parameter B3 = 1'b7;
 parameter Count = 1'b8;
 parameter Wait = 1'b9;
 
 // State transitions
 always @(posedge clk or negedge reset) begin
    if (!reset) begin
        done <= 0;
        counting <= 0;
        shift_ena <= 0;
        B3_next <= 0;
        S_next <= 0;
        S1_next <= 0;
        Count_next <= 0;
        Wait_next <= 0;
    end else begin
        // Default next state logic
        done <= (state == Wait) ? 1'b1 : 1'b0;
        counting <= (state == Count) ? 1'b1 : 1'b0;
        shift_ena <= (state == B3 || state == B2 || state == B1 || state == B0) ? 1'b1 : 1'b0;
        
        case (state)
            S: begin
                S_next <= (d == 1'b0) ? 1'b1 : 1'b0;
                S1_next <= (d == 1'b1) ? 1'b1 : 1'b0;
            end
            
            S1: begin
                S1_next <= (d == 1'b0) ? 1'b1 : 1'b0;
            end
            
            S110: begin
                S_next <= (d == 1'b0) ? 1'b1 : 1'b0;
            end
            
            Wait: begin
                Wait_next <= (ack == 1'b0) ? 1'b1 : 1'b0;
            end
            
            Count: begin
                Count_next <= (done_counting == 1'b0 || state == B3) ? 1'b1 : 1'b0;
            end
        endcase
        
        B3_next <= (state == B2) ? 1'b1 : 1'b0;
    end
 end

endmodule
