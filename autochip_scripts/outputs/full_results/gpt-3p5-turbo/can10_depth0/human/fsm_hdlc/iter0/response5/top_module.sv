module top_module (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err);

  reg [2:0] state, next_state;
  reg prev_in;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b000;
    else
      state <= next_state;
  end

  always @(state, in) begin
    case (state)
      0: begin
           if (in)
             next_state = 1;
           else
             next_state = 0;
         end
      1: begin
           if (in)
             next_state = 2;
           else
             next_state = 0;
         end
      2: begin
           if (in)
             next_state = 3;
           else
             next_state = 0;
         end
      3: begin
           if (in)
             next_state = 4;
           else
             next_state = 0;
         end
      4: begin
           if (in)
             next_state = 5;
           else
             next_state = 0;
         end
      5: begin
           if (in)
             next_state = 6;
           else
             next_state = 4;
         end
      6: begin
           if (in)
             next_state = 7;
           else
             next_state = 4;
         end
      7: begin
           if (in)
             next_state = 7;
           else
             next_state = 0;
         end
      default: next_state = 0;
    endcase
  end

  always @(state) begin
    case (state)
      0: begin
           disc = 1'b0;
           flag = 1'b0;
           err = 1'b0;
         end
      1: begin
           disc = 1'b0;
           flag = 1'b0;
           err = 1'b0;
         end
      2: begin
           disc = 1'b0;
           flag = 1'b0;
           err = 1'b0;
         end
      3: begin
           disc = 1'b1;
           flag = 1'b0;
           err = 1'b0;
         end
      4: begin
           disc = 1'b0;
           flag = 1'b0;
           err = 1'b0;
         end
      5: begin
           disc = 1'b0;
           flag = 1'b0;
           err = 1'b0;
         end
      6: begin
           disc = 1'b0;
           flag = 1'b1;
           err = 1'b0;
         end
      7: begin
           disc = 1'b0;
           flag = 1'b0;
           err = 1'b1;
         end
      default: begin
                  disc = 1'b0;
                  flag = 1'b0;
                  err = 1'b0;
               end
    endcase
  end

  always @(posedge clk or posedge reset) begin
    if (reset)
      prev_in <= 1'b0;
    else
      prev_in <= in;
  end

endmodule
