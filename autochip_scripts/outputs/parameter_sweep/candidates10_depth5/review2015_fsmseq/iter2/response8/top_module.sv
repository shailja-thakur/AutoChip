module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  
  // Define state values
  parameter IDLE = 4'b0000;
  parameter S1 = 4'b0001;
  parameter S2 = 4'b0010;
  parameter S3 = 4'b0011;
  parameter S4 = 4'b0100;

  // Create a 3-bit shift register
  reg [2:0] shift_register;
  wire [3:0] pattern = 4'b1101;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      start_shifting <= 0;
    end
    else begin
      case (state)
        IDLE: begin
          if (data) begin
            shift_register <= {shift_register[1:0], data};
            if (shift_register == pattern[2:0]) begin
              state <= S1;
            end
          end
        end
        
        S1: begin
          if (data) begin
            shift_register <= {shift_register[1:0], data};
            if (shift_register == pattern[1:0]) begin
              state <= S2;
            end
            else begin
              state <= S1;
            end
          end
          else begin
            state <= IDLE;
          end
        end
        
        S2: begin
          if (data) begin
            shift_register <= {shift_register[1:0], data};
            if (shift_register == pattern) begin
              state <= S4;
              start_shifting <= 1;
            end
            else begin
              state <= S1;
            end
          end
          else begin
            state <= IDLE;
          end
        end
        
        S3: begin
          if (data) begin
            shift_register <= {shift_register[1:0], data};
            if (shift_register == {pattern[3], pattern[2]}) begin
              state <= S4;
              start_shifting <= 1;
            end
            else begin
              state <= S2;
            end
          end
          else begin
            state <= IDLE;
          end
        end
        
        S4: begin
          if (data) begin
            shift_register <= {shift_register[1:0], data};
            if (shift_register == pattern[3:1]) begin
              state <= S2;
            end
            else begin
              state <= S1;
            end
          end
          else begin
            state <= IDLE;
          end
        end
      endcase
    end
  end
endmodule
