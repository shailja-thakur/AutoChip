module top_module (
  input clk,
  input in,
  input areset,
  output out
);
  // Define the states as constants
  localparam B = 2'b00;
  localparam A = 2'b01;

  // Define the state register
  reg [1:0] state;

  // Define the output register
  reg out_reg;

  always @ (posedge clk or posedge areset) begin
    if (areset)
      state <= B;
    else begin
      case(state)
        B: begin
          if (in)
            state <= A;
          else
            state <= B;
        end
        A: begin
          if (in)
            state <= A;
          else
            state <= B;
        end
      endcase
    end
  end

  always @ (state) begin
    case(state)
      B: out_reg = 1'b0;
      A: out_reg = 1'b1;
    endcase
  end

  assign out = out_reg;

endmodule
