module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [1:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00; // initial state S
    end else begin
      case (state)
        2'b00: begin // state S
          if (data) begin
            state <= 2'b01; // next state S1
          end
        end
        2'b01: begin // state S1
          if (data) begin
            state <= 2'b10; // next state S11
          end else begin
            state <= 2'b00; // next state S
          end
        end
        2'b10: begin // state S11
          if (data) begin
            state <= 2'b10; // next state S11
          end else begin
            state <= 2'b11; // next state S110
          end
        end
        2'b11: begin // state S110
          if (data) begin
            state <= 2'b11; // next state Done
          end else begin
            state <= 2'b00; // next state S
          end
        end
      endcase
    end
  end
  
  always @(state) begin
    start_shifting = (state == 2'b11); // Set output to high if state is Done
  end
  
endmodule
