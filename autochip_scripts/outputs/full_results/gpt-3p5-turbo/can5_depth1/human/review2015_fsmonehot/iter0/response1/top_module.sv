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

    always @(state or d) begin
        // State transitions
        case (state)
            10'b0000000001: begin // S
                if (d) begin
                    S_next = 1;
                end else begin
                    S_next = 0;
                end
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
                B3_next = 0;
            end
            
            10'b0000000010: begin // S1
                if (d) begin
                    S1_next = 1;
                end else begin
                    S1_next = 0;
                end
                S_next = 0;
                Count_next = 0;
                Wait_next = 0;
                B3_next = 0;
            end
            
            10'b0000000100: begin // S11
                if (d) begin
                    S1_next = 1;
                end else begin
                    S1_next = 0;
                end
                S_next = 0;
                Count_next = 0;
                Wait_next = 0;
                B3_next = 0;
            end
            
            10'b0000001000: begin // S110
                if (d) begin
                    S11_next = 1;
                end else begin
                    S11_next = 0;
                end
                S_next = 0;
                Count_next = 0;
                Wait_next = 0;
                B3_next = 0;
            end
            
            10'b0000010000: begin // B0
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
                B3_next = 1;
            end
            
            10'b0000100000: begin // B1
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
                B3_next = 1;
            end
            
            10'b0001000000: begin // B2
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
                B3_next = 1;
            end
            
            10'b0010000000: begin // B3
                S_next = 0;
                S1_next = 0;
                Count_next = 1;
                Wait_next = 0;
                B3_next = 0;
            end
            
            10'b0100000000: begin // Count
                S_next = 0;
                S1_next = 0;
                Count_next = 1;
                Wait_next = 0;
                B3_next = 0;
            end
            
            10'b1000000000: begin // Wait
                if (ack) begin
                    Wait_next = 1;
                end else begin
                    Wait_next = 0;
                end
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                B3_next = 0;
            end
            
            default: begin
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
                B3_next = 0;
            end
        endcase
    end
    
    always @(posedge clk) begin
        // Output logic
        case (state)
            10'b0000000001: begin // S
                done = 0;
                counting = 0;
                shift_ena = 0;
            end
            
            10'b0000000010: begin // S1
                done = 0;
                counting = 0;
                shift_ena = 0;
            end
            
            10'b0000000100: begin // S11
                done = 0;
                counting = 0;
                shift_ena = 0;
            end
            
            10'b0000001000: begin // S110
                done = 0;
                counting = 0;
                shift_ena = 0;
            end
            
            10'b0000010000: begin // B0
                done = 0;
                counting = 0;
                shift_ena = 1;
            end
            
            10'b0000100000: begin // B1
                done = 0;
                counting = 0;
                shift_ena = 1;
            end
            
            10'b0001000000: begin // B2
                done = 0;
                counting = 0;
                shift_ena = 1;
            end
            
            10'b0010000000: begin // B3
                done = 0;
                counting = 0;
                shift_ena = 1;
            end
            
            10'b0100000000: begin // Count
                done = 0;
                counting = 1;
                shift_ena = 0;
            end
            
            10'b1000000000: begin // Wait
                done = 1;
                counting = 0;
                shift_ena = 0;
            end
            
            default: begin
                done = 0;
                counting = 0;
                shift_ena = 0;
            end
        endcase
    end

endmodule
