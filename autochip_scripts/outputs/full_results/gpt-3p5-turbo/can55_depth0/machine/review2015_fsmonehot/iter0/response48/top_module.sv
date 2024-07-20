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

    // Define the states
    localparam [9:0] S = 10'b0000000001; // State S
    localparam [9:0] S1 = 10'b0000000010; // State S1
    localparam [9:0] S11 = 10'b0000000100; // State S11
    localparam [9:0] S110 = 10'b0000001000; // State S110
    localparam [9:0] B0 = 10'b0000010000; // State B0
    localparam [9:0] B1 = 10'b0000100000; // State B1
    localparam [9:0] B2 = 10'b0001000000; // State B2
    localparam [9:0] B3 = 10'b0010000000; // State B3
    localparam [9:0] Count = 10'b0100000000; // State Count
    localparam [9:0] Wait = 10'b1000000000; // State Wait

    // Next state logic
    always @(state) begin
        case (state)
            S: begin
                S_next = (d == 0);
                S1_next = (d == 1);
                B3_next = 0;
                Count_next = 0;
                Wait_next = (ack == 1);
            end

            S1: begin
                S_next = (d == 0);
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = (ack == 1);
            end

            S11: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end

            S110: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end

            B0: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end

            B1: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end

            B2: begin
                S_next = 0;
                S1_next = 0;
                B3_next = (state == B2);
                Count_next = 0;
                Wait_next = 0;
            end

            B3: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end

            Count: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = (state == B3) || (done_counting == 0);
                Wait_next = 0;
            end

            Wait: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = (state == Count) && (done_counting == 1);
            end

            default: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
        endcase
    end

    // Done signal
    assign done = (state == Wait);

    // Counting signal
    assign counting = (state == Count);

    // Shift enable signal
    assign shift_ena = (state == B0) || (state == B1) || (state == B2) || (state == B3);
    
endmodule
