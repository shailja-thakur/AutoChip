module top_module (
  input clk,
  input reset,
  input in,
  output wire disc,
  output wire flag,
  output wire err
  );

  reg [2:0] state;
  reg [2:0] next_state;
  reg disc_tmp;
  reg flag_tmp;
  reg err_tmp;

  always @(posedge clk or posedge reset)
  begin
    if (reset)
      state <= 3'b000;
    else
      state <= next_state;
  end

  always @(state or in)
  begin
    disc_tmp = 0;
    flag_tmp = 0;
    err_tmp = 0;

    case (state)
      3'b000: 
        if (in == 1)
          next_state = 3'b001;
        else
          next_state = 3'b000;
        
      3'b001: 
        if (in == 1)
          next_state = 3'b010;
        else
          next_state = 3'b000;

      3'b010: 
        if (in == 1)
        begin
          next_state = 3'b011;
          disc_tmp = 1;
        end
        else
          next_state = 3'b000;
        
      3'b011: 
        if (in == 1)
        begin
          next_state = 3'b100;
          err_tmp = 1;
        end
        else
          next_state = 3'b101;

      3'b100: 
        if (in == 1)
          next_state = 3'b100;
        else
          next_state = 3'b000;

      3'b101: 
        if (in == 1)
        begin
          next_state = 3'b011;
          flag_tmp = 1;
        end
        else
          next_state = 3'b000;
    endcase
  end

  assign disc = disc_tmp;
  assign flag = flag_tmp;
  assign err = err_tmp;

endmodule
