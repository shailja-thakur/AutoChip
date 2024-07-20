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

always @(*)
begin
    case(state)
        // State S
        10'd0: 
        begin
            if(d == 0)
                S_next = 1;
            else
                S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        // State S1
        10'd1:
        begin
            if(d == 0)
                S1_next = 1;
            else
                S1_next = 0;
            S_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        // State S11
        10'd2:
        begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        // State S110
        10'd3:
        begin
            if(d == 0)
                S_next = 1;
            else
                S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        // State B0
        10'd4:
        begin
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
            if(state[0])
                shift_ena = 1;
            else
                shift_ena = 0;
        end
        
        // State B1
        10'd5:
        begin
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
            if(state[1])
                shift_ena=1;
            else
                shift_ena = 0;
        end
        
        // State B2
        10'd6:
        begin
            if(B2 == 1)
                B3_next = 1;
            else
                B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
            if(state[2])
                shift_ena = 1;
            else
                shift_ena = 0;
        end
        
        // State B3
        10'd7:
        begin
            if(state[7])
                B3_next = 1;
            else
                B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
            shift_ena = 1;
        end
        
        // State Count
        10'd8:
        begin
            if(state[7] || state[8])
                Count_next = 1;
            else
                Count_next = 0;
            B3_next = 0;
            Wait_next = 0;
            if(done_counting == 0)
                counting = 1;
            else
                counting = 0;
        end
        
        // State Wait
        10'd9:
        begin
            if(state[8])
                Wait_next = 1;
            else
                Wait_next = 0;
            B3_next = 0;
            Count_next = 0;
            if(ack == 1)
                done = 1;
            else
                done = 0;
        end
        
        default:
        begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
            counting = 0;
            shift_ena = 0;
            done = 0;
        end
    endcase
    
    // Next state logic
    if(state == 10'd9 && done_counting == 1)
        next_state = 10'd9;
    else if(state == 10'd8 && done_counting == 0)
        next_state = 10'd8;
    else if(state == 10'd7 || state == 10'd6 || state == 10'd5 || state == 10'd4)
        next_state = 10'd7;
    else if(state == 10'd3 && d == 0)
        next_state = 10'd3;
    else if(state == 10'd2)
        next_state = 10'd2;
    else if(state == 10'd1 && d == 1)
        next_state = 10'd1;
    else if(state == 10'd0 && d == 0)
        next_state = 10'd0;
    else
        next_state = 10'd9; // Default to Wait state
    
end

// Update current state
always @(posedge clk)
begin
    state <= next_state;
end

endmodule
