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

   always @(*) begin

        // State transition logic
        case (state)
        
            10'b0000000001: begin // S
                if(d == 1) begin
                    S_next = 1;
                end
                else begin
                    S_next = 0;
                end
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
                B3_next = 0;
            end
            
            10'b0000000010: begin // S1
                if(d == 1) begin
                    S_next = 0;
                    S1_next = 1;
                end
                else begin
                    S_next = 1;
                    S1_next = 0;
                end
                Count_next = 0;
                Wait_next = 0;
                B3_next = 0;
            end
            
            10'b0000000100: begin // S11
                if(d == 1) begin
                    S_next = 0;
                    S1_next = 1;
                end
                else begin
                    S_next = 1;
                    S1_next = 0;
                end
                Count_next = 0;
                Wait_next = 0;
                B3_next = 0;
            end
            
            10'b0000001000: begin // S110
                if(d == 1) begin
                    S_next = 0;
                    S1_next = 1;
                    B3_next = 0;
                end
                else begin
                    S_next = 1;
                    S1_next = 0;
                    B3_next = 0;
                end
                Count_next = 0;
                Wait_next = 0;
            end
            
            10'b1000000000: begin // B3
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
                B3_next = 1;
            end
            
            10'b0000100000: begin // Count
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                if(done_counting) begin
                    Count_next = 0;
                    Wait_next = 1;
                end
                else begin
                    Count_next = 1;
                    Wait_next = 0;
                end
            end
            
            10'b0000000000: begin // Wait
                S_next = 10'b0000000001;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
                B3_next = 0;
            end
            
        endcase
    end

    // Output logic
    always @(*) begin
        done = (state == 10'b0000000000) & (ack == 1);
        counting = (state == 10'b0000100000);
        shift_ena = (state >= 10'b1000000000);
    end

endmodule
