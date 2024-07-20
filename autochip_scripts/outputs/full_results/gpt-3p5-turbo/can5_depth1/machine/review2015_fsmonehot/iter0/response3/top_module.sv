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

parameter S = 10'b00_000_0001;
parameter S1 = 10'b00_000_0010;
parameter S11 = 10'b00_000_0100;
parameter S110 = 10'b00_000_1000;
parameter B0 = 10'b00_001_0000;
parameter B1 = 10'b00_010_0000;
parameter B2 = 10'b00_100_0000;
parameter B3 = 10'b01_000_0000;
parameter Count = 10'b10_000_0000;
parameter Wait = 10'b00_000_0011;

always @(state, d, done_counting, ack) begin
    case(state)
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
            Wait_next = (ack == 0);
        end
        
        S11: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        S110: begin
            S_next = (d == 0);
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
            B3_next = 1;
            Count_next = 0;
            Wait_next = 0;
        end
        
        B3: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 1;
            Wait_next = 0;
        end
        
        Count: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = (done_counting == 0) || (state == B3);
            Wait_next = (done_counting == 1);
        end
        
        Wait: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = (ack == 0);
        end
    endcase
end

always @(posedge clk) begin
  if (rst) begin
    state <= S;
    done <= 0;
    counting <= 0;
    shift_ena <= 0;
  end else begin
    state <= next_state;
    done <= (state == Wait);
    counting <= (state == Count);
    shift_ena <= (state == B3) || (state == B2) || (state == B1) || (state == B0);
  end
end

assign next_state = (S_next) ? S :
                    (S1_next) ? S1 :
                    (state == S11) ? S110 :
                    (state == S110) ? S1 :
                    (state == Wait_next) ? Wait :
                    (state == Count_next) ? Count :
                    (state == B0) ? B1 :
                    (state == B1) ? B2 :
                    (state == B2) ? B3 :
                    (state == B3) ? B3 :
                    state;

endmodule
