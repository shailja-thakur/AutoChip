module top_module (
  input clk,
  input resetn,
  input [2:0] r,
  output reg [2:0] g
);

  reg [1:0] state;
  reg [1:0] next;

  always @(posedge clk) begin
    if (!resetn) begin
      state <= 2'b00; // set state to A
    end else begin
      state <= next; // set state to the value of next
    end
  end

  always @(*) begin
    case (state)
      2'b00: begin // state A
        if (r[0]) begin
          next = 2'b01; // next state is B
        end else if (r[1]) begin
          next = 2'b10; // next state is C
        end else if (r[2]) begin
          next = 2'b11; // next state is D
        end else begin
          next = 2'b00; // next state is A
        end
      end
      2'b01: begin // state B
        if (r[0]) begin
          next = 2'b01; // next state is B
        end else begin
          next = 2'b00; // next state is A
        end
      end
      2'b10: begin // state C
        if (r[1]) begin
          next = 2'b10; // next state is C
        end else begin
          next = 2'b00; // next state is A
        end
      end
      2'b11: begin // state D
        if (r[2]) begin
          next = 2'b11; // next state is D
        end else begin
          next = 2'b00; // next state is A
        end
      end
    endcase
  end

  always @(state) begin
    case (state)
      2'b00: begin // state A
        g = 3'b000; // all bits of g are low
      end
      2'b01: begin // state B
        g = {1'b1, 2'b00}; // g[1] is high, g[2:0] are low
      end
      2'b10: begin // state C
        g = {1'b0, 1'b1, 1'b0}; // g[2] is high, g[1] and g[3] are low
      end
      2'b11: begin // state D
        g = {1'b0, 2'b0, 1'b1}; // g[3] is high, g[1:2] are low
      end
    endcase
  end

endmodule
