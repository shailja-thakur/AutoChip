module top_module(
    input wire d,
    input wire done_counting,
    input wire ack,
    input wire [9:0] state,    // 10-bit one-hot current state
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

// State logic and next state assignments
always @* begin
    case(state)
        S: begin
            B3_next = 0;
            S_next = (d == 0);
            S1_next = (d == 1);
            Count_next = 0;
            Wait_next = 0;
        end
        
        S1: begin
            B3_next = 0;
            S_next = (d == 0);
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        S11: begin
            B3_next = 0;
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        S110: begin
            B3_next = 0;
            S_next = (d == 0);
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        B0: begin
            B3_next = 0;
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        B1: begin
            B3_next = 0;
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        B2: begin
            B3_next = 1;
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        B3: begin
            B3_next = 0;
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        Count: begin
            B3_next = 0;
            S_next = 0;
            S1_next = 0;
            Count_next = ((state == B3) || (done_counting == 0));
            Wait_next = ((state == B3) && (done_counting == 1));
        end
        
        Wait: begin
            B3_next = 0;
            S_next = (d == 0);
            S1_next = 0;
            Count_next = ((state == B3) || (done_counting == 0));
            Wait_next = ((state == B3) && (done_counting == 1));
        end
    endcase
end

// Output assignments
always @* begin
    done = (state == Wait);
    counting = (state == Count);
    shift_ena = ((state == B3) || (state == B2) || (state == B1) || (state == B0));
end

endmodule
