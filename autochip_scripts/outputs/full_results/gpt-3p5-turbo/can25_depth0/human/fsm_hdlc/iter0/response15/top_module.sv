module top_module (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err);

  reg [2:0] state, next_state;
  
  parameter IDLE = 3'b000;
  parameter BIT1 = 3'b001;
  parameter BIT2 = 3'b010;
  parameter FLAG = 3'b011;
  parameter ERR = 3'b100;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end
    else begin
      state <= next_state;
    end
  end
  
  always @(*) begin
    next_state = state;
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    
    case (state)
      IDLE: begin
        if (in == 1'b0) begin
          next_state = BIT1;
        end
      end
      
      BIT1: begin
        if (in == 1'b0) begin
          next_state = BIT2;
        end
        else if (in == 1'b1) begin
          next_state = ERR;
          err = 1'b1;
        end
      end
      
      BIT2: begin
        if (in == 1'b0) begin
          next_state = FLAG;
        end
        else if (in == 1'b1) begin
          next_state = ERR;
          err = 1'b1;
        end
      end
      
      FLAG: begin
        if (in == 1'b0) begin
          next_state = IDLE;
          flag = 1'b1;
        end
        else if (in == 1'b1) begin
          next_state = ERR;
          err = 1'b1;
        end
        else if (in == 1'b1) begin
          next_state = ERR;
          err = 1'b1;
        end
      end
      
      ERR: begin
        next_state = IDLE;
      end
    endcase
  end
endmodule
