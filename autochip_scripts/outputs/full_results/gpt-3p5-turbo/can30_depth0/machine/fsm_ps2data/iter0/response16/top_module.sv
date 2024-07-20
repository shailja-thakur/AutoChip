module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
  reg [23:0] register;
  reg [1:0] state;
  
  always @(posedge clk, posedge reset) begin
    if (reset)
      state <= 2'b00;
    else begin
      case (state)
        2'b00: begin
          if (in[2])
            state <= 2'b01;
          else
            state <= 2'b00;
        end
        2'b01: begin
          state <= 2'b10;
        end
        2'b10: begin
          state <= 2'b11;
        end
        2'b11: begin
          if (in[2])
            state <= 2'b11;
          else
            state <= 2'b00;
        end
        default: state <= 2'b00;
      endcase
    end
  end
  
  always @(posedge clk) begin
    if (done)
      out_bytes <= register;
    else
      out_bytes <= out_bytes << 8;
    register <= in;
  end
  
  assign done = (state == 2'b11);
  
endmodule
