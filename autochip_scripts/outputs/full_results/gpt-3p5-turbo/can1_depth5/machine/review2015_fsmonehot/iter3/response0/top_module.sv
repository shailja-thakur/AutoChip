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
  parameter S = 10'b0000000001;
  parameter S1 = 10'b0000000010;
  parameter S11 = 10'b0000000100;
  parameter S110 = 10'b0000001000;
  parameter B0 = 10'b0000010000;
  parameter B1 = 10'b0000100000;
  parameter B2 = 10'b0001000000;
  parameter B3 = 10'b0010000000;
  parameter Count = 10'b0100000000;
  parameter Wait = 10'b1000000000;
  
  reg [9:0] state_temp;
  always @(posedge clk) begin
    if(reset) begin
      state_temp <= S;
    end else begin
      state_temp <= state;
    end
  end
  
  always @(*) begin
    case(state_temp)
      S: begin
        B3_next = 1'b0;
        S_next = (d == 1'b0);
        S1_next = (d == 1'b1);
        Count_next = 1'b0;
        Wait_next = 1'b0;
      end
      
      S1: begin
        B3_next = 1'b0;
        S_next = (d == 1'b0);
        S1_next = (d == 1'b1);
        Count_next = 1'b0;
        Wait_next = 1'b0;
      end
      
      S11: begin
        B3_next = 1'b0;
        S_next = (d == 1'b0);
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
      end
      
      S110: begin
        B3_next = 1'b0;
        S_next = (d == 1'b0);
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
      end
      
      B0: begin
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
      end
      
      B1: begin
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
      end
      
      B2: begin
        B3_next = 1'b1;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
      end
      
      B3: begin
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b1;
        Wait_next = 1'b0;
      end
      
      Count: begin
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = (done_counting == 1'b0);
        Wait_next = 1'b0;
      end
      
      Wait: begin
        B3_next = 1'b0;
        S_next = (d == 1'b0 && ack == 1'b1);
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = (ack == 1'b0);
      end
    endcase
  end
  
  always @(state_temp) begin
    done = (state_temp == Wait);
    counting = (state_temp == Count);
  end
  
  always @(state_temp) begin
    shift_ena = (state_temp[B3] || state_temp[B2] || state_temp[B1] || state_temp[B0]);
  end
  
endmodule
