module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);

  reg [1:0] ena_reg;
  reg [99:0] output_reg;
  
  always @(posedge clk) begin
    ena_reg <= ena;
    
    if (load) begin
      output_reg <= data;
    end else begin
      case (ena_reg)
        2'b01: output_reg <= {output_reg[98:0], output_reg[99]};
        2'b10: output_reg <= {output_reg[0], output_reg[99:1]};
        default: output_reg <= output_reg;
      endcase
    end
  end
  
  always @(posedge clk) begin
    q <= output_reg;
  end

endmodule
