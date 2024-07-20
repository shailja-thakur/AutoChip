module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

  reg [3:1] state;
  reg [3:1] next;

  always @(posedge clk) begin
    if (!resetn) begin
      state <= 3'b001; // Set state to A when reset signal is low
    end else begin
      state <= next; // Set state to next state value
    end
  end

  always @* begin
    case (state)
      3'b001: begin // State A
        if (r[1]) next = 3'b010; // Next state is B if r[1] is high
        else if (r[2]) next = 3'b011; // Next state is C if r[2] is high
        else if (r[3]) next = 3'b100; // Next state is D if r[3] is high
        else next = 3'b001; // Next state is A if no bits of r are high
      end

      3'b010: begin // State B
        if (r[1]) next = 3'b010; // Next state is B if r[1] is high
        else next = 3'b001; // Next state is A if r[1] is low
      end

      3'b011: begin // State C
        if (r[2]) next = 3'b011; // Next state is C if r[2] is high
        else next = 3'b001; // Next state is A if r[2] is low
      end

      3'b100: begin // State D
        if (r[3]) next = 3'b100; // Next state is D if r[3] is high
        else next = 3'b001; // Next state is A if r[3] is low
      end
    endcase
  end

  assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0; // Set g[1] high if current state is B
  assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0; // Set g[2] high if current state is C
  assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0; // Set g[3] high if current state is D

endmodule
