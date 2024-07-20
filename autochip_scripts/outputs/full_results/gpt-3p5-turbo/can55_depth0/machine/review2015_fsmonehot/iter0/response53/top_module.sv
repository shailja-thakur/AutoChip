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

 // Intermediate signals
 wire S;
 wire S1;
 wire S11;
 wire S110;
 wire B0;
 wire B1;
 wire B2;
 wire B3;
 
 // State assignments
 assign S    = state[0];
 assign S1   = state[1];
 assign S11  = state[2];
 assign S110 = state[3];
 assign B0   = state[4];
 assign B1   = state[5];
 assign B2   = state[6];
 assign B3   = state[7];
 
 // State transition logic
 always @(*) begin
    // B3_next
    if (B2) begin
        B3_next = 1;
    end else begin
        B3_next = 0;
    end
    
    // S_next
    if ((S && !d) || (S1 && !d) || (S110 && !d) || (Wait && ack)) begin
        S_next = 1;
    end else begin
        S_next = 0;
    end
    
    // S1_next
    if (S && d) begin
        S1_next = 1;
    end else begin
        S1_next = 0;
    end
    
    // Count_next
    if (B3 || (Count && !done_counting)) begin
        Count_next = 1;
    end else begin
        Count_next = 0;
    end
    
    // Wait_next
    if ((Count && done_counting) || (Wait && !ack)) begin
        Wait_next = 1;
    end else begin
        Wait_next = 0;
    end
 end
 
 // Output assignments
 assign counting = state[8];
 assign done = state[9];
 assign shift_ena = B3 || B2 || B1 || B0;
 
 endmodule
