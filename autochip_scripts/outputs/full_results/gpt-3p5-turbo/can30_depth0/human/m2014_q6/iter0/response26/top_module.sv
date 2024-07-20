module state_machine (
  input wire clk,
  input wire reset,
  input wire w,
  output wire z
);

  // Defining the states
  localparam A = 2'b00;
  localparam B = 2'b01;
  localparam C = 2'b10;
  localparam D = 2'b11;
  
  // Defining the state register and next state logic
  reg [1:0] state;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= A;
    end else begin
      case(state)
        A: begin
          if (w == 1'b0)
            state <= B;
          else
            state <= A;
        end
        B: begin
          if (w == 1'b0)
            state <= C;
          else
            state <= D;
        end
        C: begin
          if (w == 1'b0 && z == 1'b0)
            state <= E;
          else
            state <= D;
        end
        D: begin
          if (w == 1'b0)
            state <= F;
          else
            state <= A;
        end
        E: begin
          if (w == 1'b0)
            state <= E;
          else
            state <= D;
        end
        F: begin
          if (w == 1'b0)
            state <= C;
          else
            state <= D;
        end
      endcase
    end
  end
  
  // Assigning output based on the current state
  always @(state) begin
    case(state)
      A: z <= 1'b0;
      B: z <= 1'b0;
      C: z <= 1'b0;
      D: z <= 1'b0;
      E: z <= 1'b1;
      F: z <= 1'b1;
    endcase
  end

endmodule
module top_module (
  input clk,
  input reset,
  input w,
  output z
);
  
  state_machine sm(
    .clk(clk),
    .reset(reset),
    .w(w),
    .z(z)
  );
  
endmodule
