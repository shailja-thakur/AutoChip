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
    
    // Define internal signals
    reg B3_next_temp;
    reg S_next_temp;
    reg S1_next_temp;
    reg Count_next_temp;
    reg Wait_next_temp;
    reg done_temp;
    reg counting_temp;
    reg shift_ena_temp;
    
    // Assign default values to the internal signals
    always @(state, d, done_counting, ack) begin
        B3_next_temp = (state == B2) ? 1'b1 : 1'b0;
        S_next_temp = ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1)) ? 1'b1 : 1'b0;
        S1_next_temp = (state == S && d == 1) ? 1'b1 : 1'b0;
        Count_next_temp = (state == B3 || (state == Count && done_counting == 0)) ? 1'b1 : 1'b0;
        Wait_next_temp = ((state == Count && done_counting == 1) || (state == Wait && ack == 0)) ? 1'b1 : 1'b0;
        done_temp = (state == Wait) ? 1'b1 : 1'b0;
        counting_temp = (state == Count) ? 1'b1 : 1'b0;
        shift_ena_temp = (state == B3 || state == B2 || state == B1 || state == B0) ? 1'b1 : 1'b0;
    end
    
    // Synchronous update of the output signals
    always @(posedge clk) begin
        B3_next <= B3_next_temp;
        S_next <= S_next_temp;
        S1_next <= S1_next_temp;
        Count_next <= Count_next_temp;
        Wait_next <= Wait_next_temp;
        done <= done_temp;
        counting <= counting_temp;
        shift_ena <= shift_ena_temp;
    end

 endmodule
