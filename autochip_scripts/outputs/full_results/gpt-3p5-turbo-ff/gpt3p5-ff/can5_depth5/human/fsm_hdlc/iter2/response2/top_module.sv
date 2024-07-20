module top_module (
  input clk,
  input reset,
  input in,
  output reg disc,
  output reg flag,
  output reg err);

  reg [2:0] state;
  reg [2:0] next_state;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
    end else begin
      state <= next_state;
    end
  end

  always @(state or in) begin
    case(state)
      3'b000: begin
        next_state = (in) ? 3'b001 : 3'b000;
        disc = 0;
        flag = 0;
        err = 0;
      end
      3'b001: begin
        next_state = (in) ? 3'b010 : 3'b000;
        disc = 0;
        flag = 0;
        err = 0;
      end
      3'b010: begin
        next_state = (in) ? 3'b011 : 3'b000;
        disc = 0;
        flag = 0;
        err = 0;
      end
      3'b011: begin
        next_state = (in) ? 3'b100 : 3'b000;
        disc = 1;
        flag = 0;
        err = 0;
      end
      3'b100: begin
        next_state = (in) ? 3'b101 : 3'b000;
        disc = 0;
        flag = 1;
        err = 0;
      end
      3'b101: begin
        next_state = (in) ? 3'b110 : 3'b000;
        disc = 0;
        flag = 0;
        err = 0;
      end
      3'b110: begin
        next_state = (in) ? 3'b111 : 3'b000;
        disc = 0;
        flag = 0;
        err = 1;
      end
      3'b111: begin
        next_state = (in) ? 3'b111 : 3'b000;
        disc = 0;
        flag = 0;
        err = 1;
      end
      default: next_state = 3'b000;
    endcase
  end
  
endmodule
