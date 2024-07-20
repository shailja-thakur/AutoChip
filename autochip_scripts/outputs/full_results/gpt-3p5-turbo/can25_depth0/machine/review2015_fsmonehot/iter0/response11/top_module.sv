module top_module (
    input d,
    input done_counting,
    input ack,
    input [9:0] state,
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
);

    // State assignments
    localparam S = 0;
    localparam S1 = 1;
    localparam S11 = 2;
    localparam S110 = 3;
    localparam B0 = 4;
    localparam B1 = 5;
    localparam B2 = 6;
    localparam B3 = 7;
    localparam Count = 8;
    localparam Wait = 9;
  
    // State signals
    wire S_active = (state == S);
    wire S1_active = (state == S1);
    wire S11_active = (state == S11);
    wire S110_active = (state == S110);
    wire B0_active = (state == B0);
    wire B1_active = (state == B1);
    wire B2_active = (state == B2);
    wire B3_active = (state == B3);
    wire Count_active = (state == Count);
    wire Wait_active = (state == Wait);
  
    // Assign outputs based on state conditions
    assign B3_next = B2_active;
    assign S_next = (S_active && !d) || (S1_active && !d) || (S110_active && !d) || (Wait_active && ack);
    assign S1_next = (S_active && d);
    assign Count_next = B3_active || (Count_active && !done_counting);
    assign Wait_next = (Count_active && done_counting) || (Wait_active && !ack);
  
    // Assign outputs based on state
    assign done = Wait_active;
    assign counting = Count_active;
    assign shift_ena = B3_active || B2_active || B1_active || B0_active;

endmodule
