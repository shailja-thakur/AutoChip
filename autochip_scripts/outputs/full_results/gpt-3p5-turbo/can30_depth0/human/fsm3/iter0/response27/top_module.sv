module top_module (
    input clk,
    input in,
    input areset,
    output out
);

// Define the four states as parameters
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define the state register
reg [1:0] state;

// Define the next state logic
always @(posedge clk or posedge areset)
begin
  if (areset)
    state <= A;
  else
    case (state)
      A: state <= (in) ? B : A;
      B: state <= (in) ? B : C;
      C: state <= (in) ? D : A;
      D: state <= (in) ? B : C;
    endcase
end

// Define the output logic
always @*
begin
  case (state)
    A: out = 1'b0;
    B: out = 1'b0;
    C: out = 1'b0;
    D: out = 1'b1;
  endcase
end

endmodule
