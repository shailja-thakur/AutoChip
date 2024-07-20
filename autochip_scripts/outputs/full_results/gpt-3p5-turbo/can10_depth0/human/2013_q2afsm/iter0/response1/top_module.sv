module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);
  // Define the states
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;
  
  // Define the signals
  reg [1:0] state;
  
  // Assign the initial state
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      state <= A;
    else
      state <= state;
  end
  
  // Define the next state logic
  always @(state or r) begin
    case (state)
      A: begin
        if (r[1] & !r[2] & !r[3])
          state <= B;
        else if (!r[1] & r[2] & !r[3])
          state <= C;
        else if (!r[1] & !r[2] & !r[3])
          state <= D;
        else
          state <= A;
      end
      B: begin
        if (r[1])
          state <= B;
        else
          state <= A;
      end
      C: begin
        if (r[2])
          state <= C;
        else
          state <= A;
      end
      D: begin
        state <= A;
      end
    endcase
  end
  
  // Define the output logic
  always @(state) begin
    case (state)
      A: g <= 3'b000;
      B: g <= 3'b100;
      C: g <= 3'b010;
      D: g <= 3'b001;
    endcase
  end
endmodule
