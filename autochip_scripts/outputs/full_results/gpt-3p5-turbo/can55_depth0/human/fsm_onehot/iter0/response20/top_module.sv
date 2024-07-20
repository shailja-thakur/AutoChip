module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2);
  
  // Define the state representation
  localparam S0 = 10'b0000000001;
  localparam S1 = 10'b0000000010;
  localparam S2 = 10'b0000000100;
  localparam S3 = 10'b0000001000;
  localparam S4 = 10'b0000010000;
  localparam S5 = 10'b0000100000;
  localparam S6 = 10'b0001000000;
  localparam S7 = 10'b0010000000;
  localparam S8 = 10'b0100000000;
  localparam S9 = 10'b1000000000;
  
  // Next state and output generation logic
  always @* begin
    case (state)
      S0:
        begin
          if (in)
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1};
              out1 = 1'b0;
              out2 = 1'b0;
            end
          else
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1};
              out1 = 1'b0;
              out2 = 1'b0;
            end
        end
      S1:
        begin
          if (in)
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
              out1 = 1'b0;
              out2 = 1'b0;
            end
          else
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
              out1 = 1'b0;
              out2 = 1'b0;
            end
        end
      S2:
        begin
          if (in)
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1};
              out1 = 1'b0;
              out2 = 1'b0;
            end
          else
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1};
              out1 = 1'b0;
              out2 = 1'b0;
            end
        end
      S3:
        begin
          if (in)
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1};
              out1 = 1'b0;
              out2 = 1'b0;
            end
          else
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1};
              out1 = 1'b0;
              out2 = 1'b0;
            end
        end
      S4:
        begin
          if (in)
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1};
              out1 = 1'b0;
              out2 = 1'b0;
            end
          else
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1};
              out1 = 1'b0;
              out2 = 1'b0;
            end
        end
      S5:
        begin
          if (in)
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
              out1 = 1'b1;
              out2 = 1'b0;
            end
          else
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1};
              out1 = 1'b0;
              out2 = 1'b0;
            end
        end
      S6:
        begin
          if (in)
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
              out1 = 1'b0;
              out2 = 1'b1;
            end
          else
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
              out1 = 1'b0;
              out2 = 1'b0;
            end
        end
      S7:
        begin
          if (in)
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1};
              out1 = 1'b0;
              out2 = 1'b1;
            end
          else
            begin
              next_state = state;
              out1 = 1'b0;
              out2 = 1'b1;
            end
        end
      S8:
        begin
          if (in)
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
              out1 = 1'b1;
              out2 = 1'b0;
            end
          else
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
              out1 = 1'b0;
              out2 = 1'b0;
            end
        end
      S9:
        begin
          if (in)
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1};
              out1 = 1'b1;
              out2 = 1'b1;
            end
          else
            begin
              next_state = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1};
              out1 = 1'b0;
              out2 = 1'b0;
            end
        end
    endcase
  end
endmodule
