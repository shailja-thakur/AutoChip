module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);
  
  reg [511:0] temp;
  
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      temp[0] = q[1];
      temp[511] = q[510];
      
      for (int i = 1; i < 511; i = i + 1) begin
        case ({q[i-1], q[i], q[i+1]})
          3'b111 : temp[i] = 1'b0;
          3'b110 : temp[i] = 1'b1;
          3'b101 : temp[i] = 1'b1;
          3'b100 : temp[i] = 1'b0;
          3'b011 : temp[i] = 1'b1;
          3'b010 : temp[i] = 1'b1;
          3'b001 : temp[i] = 1'b1;
          3'b000 : temp[i] = 1'b0;
        endcase
      end
      
      temp[511] = 1'b0;
      
      q <= temp;
    end
  end
  
endmodule
