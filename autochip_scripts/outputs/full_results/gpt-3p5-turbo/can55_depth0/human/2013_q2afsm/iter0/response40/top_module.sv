module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

// Define the states as parameters
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Declare the state registers
reg [1:0] state_reg;
reg [1:0] state_next;

// Declare the output registers
reg [3:1] g_reg;

// Assign initial values to registers
initial begin
  state_reg = A;
  state_next = A;
  g_reg = 3'b000;
end

// State flip-flop
always @(posedge clk or negedge resetn) begin
  if (~resetn) begin
    state_reg <= A;
  end else begin
    state_reg <= state_next;
  end
end

// State table
always @(*) begin
  case (state_reg)

    A: begin
      if (r[3:1] == 3'b000) begin
        state_next = A;
        g_reg = 3'b000;
      end else if (r[1] == 1'b1) begin
        state_next = B;
        g_reg = 3'b001;
      end else if (r[2] == 1'b1) begin
        state_next = C;
        g_reg = 3'b010;
      end else begin
        state_next = D;
        g_reg = 3'b000;
      end
    end

    B: begin
      if (r[1] == 1'b1) begin
        state_next = B;
        g_reg = 3'b001;
      end else begin
        state_next = A;
        g_reg = 3'b000;
      end
    end

    C: begin
      if (r[2] == 1'b1) begin
        state_next = C;
        g_reg = 3'b010;
      end else begin
        state_next = A;
        g_reg = 3'b000;
      end
    end

    D: begin
      state_next = A;
      g_reg = 3'b000;
    end

  endcase
end

// Continuous assignment for g outputs
assign g = g_reg;

endmodule
