module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
 );

reg B3_next_reg;
reg S_next_reg;
reg S1_next_reg;
reg Count_next_reg;
reg Wait_next_reg;
reg done_reg;
reg counting_reg;
reg shift_ena_reg;

always @(state) begin
    case (state)
        10'b0000000001: begin // S
            S_next_reg = (d == 0) ? 1'b1 : 1'b0;
            S1_next_reg = (d == 1) ? 1'b1 : 1'b0;
        end
        
        10'b0000000010: begin // S1
            S_next_reg = (d == 0) ? 1'b1 : 1'b0;
            S1_next_reg = (d == 1) ? 1'b1 : 1'b0;
            shift_ena_reg = 1'b0;
        end
        
        10'b0000000100: begin // S11
            S_next_reg = (d == 0) ? 1'b1 : 1'b0;
            S1_next_reg = (d == 1) ? 1'b1 : 1'b0;
        end
        
        10'b0000001000: begin // S110
            S_next_reg = (d == 0) ? 1'b1 : 1'b0;
            S1_next_reg = (d == 1) ? 1'b1 : 1'b0;
        end
        
        10'b0000001001: begin // B0
            S_next_reg = 1'b0;
            S1_next_reg = 1'b0;
            shift_ena_reg = 1'b1;
        end
        
        10'b0000001010: begin // B1
            S_next_reg = 1'b0;
            S1_next_reg = 1'b0;
            shift_ena_reg = 1'b1;
        end
        
        10'b0000001100: begin // B2
            S_next_reg = 1'b0;
            S1_next_reg = 1'b0;
            shift_ena_reg = 1'b1;
        end
        
        10'b0000010000: begin // B3
            S_next_reg = 1'b0;
            S1_next_reg = 1'b0;
            shift_ena_reg = 1'b1;
            B3_next_reg = 1'b1;
        end
        
        10'b0000100000: begin // Count
            Count_next_reg = (done_counting) ? 1'b0 : 1'b1;
        end
        
        10'b0001000000: begin // Wait
            Wait_next_reg = (ack) ? 1'b1 : 1'b0;
            done_reg = (ack) ? 1'b1 : 1'b0;
        end
    endcase
end

always @(posedge clk) begin
    B3_next <= B3_next_reg;
    S_next <= S_next_reg;
    S1_next <= S1_next_reg;
    Count_next <= Count_next_reg;
    Wait_next <= Wait_next_reg;
    done <= done_reg;
    counting <= state[8];
    shift_ena <= shift_ena_reg;
end

endmodule
