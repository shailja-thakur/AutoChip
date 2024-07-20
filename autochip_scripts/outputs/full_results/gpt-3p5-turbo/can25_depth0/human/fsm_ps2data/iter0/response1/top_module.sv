module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  // State definition
  reg [1:0] state;
  // State register initialization
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;
    end else begin
      case(state)
        2'b00: state <= (in[3] == 1'b1) ? 2'b01 : 2'b00;
        2'b01: state <= 2'b10;
        2'b10: state <= (in[3] == 1'b1) ? 2'b11 : 2'b00;
        2'b11: state <= 2'b00;
      endcase
    end
  end
  
  // Output assignment
  assign done = (state == 2'b10);
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_bytes <= 24'b0;
    end else begin
      case(state)
        2'b00: out_bytes <= 24'b0;
        2'b01: out_bytes <= {in, out_bytes[23:8]};
        2'b10: out_bytes <= {out_bytes[15:0], in, out_bytes[23:16]};
        2'b11: out_bytes <= {out_bytes[7:0], in, out_bytes[23:16]};
      endcase
    end
  end

endmodule
