module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output out
);
  
  reg [1:0] state;
  wire new_state;
  
  parameter OFF = 2'b00;
  parameter ON = 2'b01;
  
  always @(posedge clk or posedge areset)
  begin
    if (areset)
      state <= OFF;
    else
      state <= new_state;
  end

  always @(*)
  begin
    case (state)
      OFF: 
      begin
        if (j)
          new_state = ON;
        else
          new_state = OFF;
      end

      ON: 
      begin
        if (k)
          new_state = OFF;
        else
          new_state = ON;
      end

      default:
        new_state = OFF;
    end
  end

  assign out = (state == ON) ? 1'b1 : 1'b0;

endmodule
