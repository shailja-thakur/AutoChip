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

 always @(state) begin
    case(state)
        S: begin
            if(d == 0) begin
                S_next = 1;
                S1_next = 0;
            end
            else begin
                S_next = 0;
                S1_next = 1;
            end
            
            B3_next = 0;
        end
        
        S1: begin
            if(d == 0) begin
                S_next = 1;
                S1_next = 0;
            end
            else begin
                S_next = 0;
                S1_next = 0;
            end
            
            B3_next = 0;
        end
        
        S11: begin
            S_next = 0;
            S1_next = 1;
            B3_next = 0;
        end
        
        S110: begin
            if(d == 0) begin
                S_next = 1;
                S1_next = 0;
            end
            else begin
                S_next = 0;
                S1_next = 1;
            end
            
            B3_next = 0;
        end
        
        B0: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
        end
        
        B1: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
        end
        
        B2: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 1;
        end
        
        B3: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
        end
        
        Count: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            
            if(done_counting == 0) begin
                Count_next = 1;
            end
            else begin
                Count_next = 0;
            end
        end
        
        Wait: begin
            if(ack == 1) begin
                S_next = 0;
                S1_next = 0;
            end
            else begin
                if(d == 0) begin
                    S_next = 1;
                    S1_next = 0;
                end
                else begin
                    S_next = 0;
                    S1_next = 1;
                end
            end
            
            B3_next = 0;
        end
        
        default: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
        end
    endcase
 end
 
 // Output assignments
 assign done = (state == Wait) ? 1 : 0;
 assign counting = (state == Count) ? 1 : 0;
 assign shift_ena = (state == B3 || state == B2 || state == B1 || state == B0) ? 1 : 0;

 always @(posedge clk) begin
    // Register next state values
    if (reset) begin
        state <= 10'b0000000001;
    end else begin
        state <= state_next;
    end
 end
endmodule
