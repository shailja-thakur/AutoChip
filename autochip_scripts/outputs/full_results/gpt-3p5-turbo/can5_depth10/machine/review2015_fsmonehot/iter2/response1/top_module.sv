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

    // Define the states as parameters
    parameter [9:0] S = 10'b0000000001;    // S state
    parameter [9:0] S1 = 10'b0000000010;   // S1 state
    parameter [9:0] S11 = 10'b0000000011;  // S11 state
    parameter [9:0] S110 = 10'b0000000100; // S110 state
    parameter [9:0] B0 = 10'b0000001000;   // B0 state
    parameter [9:0] B1 = 10'b0000010000;   // B1 state
    parameter [9:0] B2 = 10'b0000100000;   // B2 state
    parameter [9:0] B3 = 10'b0001000000;   // B3 state
    parameter [9:0] Count = 10'b0010000000;   // Count state
    parameter [9:0] Wait = 10'b0100000000;    // Wait state
    
    // Temporary variables for the next state logic
    reg B3_next_temp;
    reg S_next_temp;
    reg S1_next_temp;
    reg Count_next_temp;
    reg Wait_next_temp;

    always @* begin
        B3_next_temp = 1'b0;
        S_next_temp = 1'b0;
        S1_next_temp = 1'b0;
        Count_next_temp = 1'b0;
        Wait_next_temp = 1'b0;
        
        if (state == B2)
            B3_next_temp = 1'b1;
            
        if ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1))
            S_next_temp = 1'b1;
            
        if (state == S && d == 1)
            S1_next_temp = 1'b1;
            
        if (state == B3 || (state == Count && done_counting == 0))
            Count_next_temp = 1'b1;
            
        if ((state == Count && done_counting == 1) || (state == Wait && ack == 0))
            Wait_next_temp = 1'b1;
    end
    
    always @(posedge clk) begin
        B3_next <= B3_next_temp;
        S_next <= S_next_temp;
        S1_next <= S1_next_temp;
        Count_next <= Count_next_temp;
        Wait_next <= Wait_next_temp;
        done <= (state == Wait) ? 1'b1 : 1'b0;
        counting <= (state == Count) ? 1'b1 : 1'b0;
        shift_ena <= (state == B3 || state == B2 || state == B1 || state == B0) ? 1'b1 : 1'b0;
    end

 endmodule
