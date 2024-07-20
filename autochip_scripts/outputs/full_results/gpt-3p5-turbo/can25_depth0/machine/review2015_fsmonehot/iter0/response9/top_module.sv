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

reg [9:0] next_state;
wire B3, B2, B1, B0;
wire S, S1, S11, S110, B0, B1, B2, B3, Count, Wait;

// State definitions
assign S = state[0];
assign S1 = state[1];
assign S11 = state[2];
assign S110 = state[3];
assign B0 = state[4];
assign B1 = state[5];
assign B2 = state[6];
assign B3 = state[7];
assign Count = state[8];
assign Wait = state[9];

always @* begin
    // Output B3_next
    B3_next = 0;
    if (B2) begin
        B3_next = 1;
    end
    
    // Output S_next
    S_next = 0;
    if ((S && (d == 0)) || (S1 && (d == 0)) || (S110 && (d == 0)) || (Wait && ack)) begin
        S_next = 1;
    end
    
    // Output S1_next
    S1_next = 0;
    if (S && (d == 1)) begin
        S1_next = 1;
    end
    
    // Output Count_next
    Count_next = 0;
    if (B3 || (Count && !done_counting)) begin
        Count_next = 1;
    end
    
    // Output Wait_next
    Wait_next = 0;
    if ((Count && done_counting) || (Wait && !ack)) begin
        Wait_next = 1;
    end
    
    // Output done
    done = Wait;
    
    // Output counting
    counting = Count;
    
    // Output shift_ena
    shift_ena = B3 || B2 || B1 || B0;
end

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        state <= 10'b0;
    end
    else begin
        state <= next_state;
    end
end

always @* begin
    case(state)
        S: next_state = d ? 1 : 0;
        S1: next_state = 2;
        S11: next_state = S110 ? 4 : 3;
        S110: next_state = 9;
        B0: next_state = 6;
        B1: next_state = 7;
        B2: next_state = 8;
        B3: next_state = B2 ? 7 : 5;
        Count: next_state = done_counting ? 9 : 8;
        Wait: next_state = done_counting ? 8 : 9;
        default: next_state = 0;
    endcase
end

endmodule
