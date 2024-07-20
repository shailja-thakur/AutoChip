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
    
    // State definitions
    localparam S = 10'b0000000001;
    localparam S1 = 10'b0000000010;
    localparam S11 = 10'b0000000100;
    localparam S110 = 10'b0000001000;
    localparam B0 = 10'b0000010000;
    localparam B1 = 10'b0000100000;
    localparam B2 = 10'b0001000000;
    localparam B3 = 10'b0010000000;
    localparam Count = 10'b0100000000;
    localparam Wait = 10'b1000000000;
    
    // State variables
    reg [9:0] next_state;
    
    // Combinational logic to compute next state
    always @(*)
    begin
        case(state)
            S:
                if (d == 0)
                    next_state = S_next ? S1 : S;
                else
                    next_state = S;
            S1:
                if (d == 1)
                    next_state = S1_next ? S11 : S1;
                else
                    next_state = S1;
            S11:
                next_state = 0;
            S110:
                next_state = 0;
            B0:
                next_state = 0;
            B1:
                next_state = 0;
            B2:
                next_state = B3 ? B3_next : B2;
            B3:
                next_state = B2 ? B3 : B3;
            Count:
                if (done_counting == 0)
                    next_state = Count_next ? B3 : Count;
                else
                    next_state = Count_next ? Wait : Count;
            Wait:
                if (ack == 0)
                    next_state = Wait_next ? Count : Wait;
                else
                    next_state = Wait;
        endcase
    end
    
    // Sequential logic to update state
    always @(posedge clk)
    begin
        state <= next_state;
    end
    
    // Output logic
    always @(*)
    begin
        done = (state == Wait) ? 1 : 0;
        counting = (state == Count) ? 1 : 0;
        shift_ena = (state == B3 || state == B2 || state == B1 || state == B0) ? 1 : 0;
    end
endmodule
