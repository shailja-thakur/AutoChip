module top_module (
  input clk,
  input a, 
  output reg [2:0] q
);

// Parameter
parameter STATE_IDLE = 0;
parameter STATE_SET_4 = 1;
parameter STATE_SET_6 = 2;
parameter STATE_INC = 3;

// State variable
reg [1:0] state;

// Next state logic
always @(posedge clk) begin
  case (state)
    STATE_IDLE: begin
      if (a) begin
        state <= STATE_SET_4;
      end else if (q == 6) begin
        state <= STATE_SET_6;
      end else begin
        state <= STATE_INC;
      end
    end
    
    STATE_SET_4: begin
      state <= STATE_IDLE;
    end
    
    STATE_SET_6: begin
      state <= STATE_IDLE;
    end
    
    STATE_INC: begin
      state <= STATE_IDLE;
    end
  endcase
end

// Output logic
always @(posedge clk) begin
  case (state)
    STATE_IDLE: begin
      if (a) begin
        q <= 4;
      end else if (q == 6) begin
        q <= 0;
      end else begin
        q <= q + 1;
      end
    end
  endcase
end

endmodule
