module top_module (
  input clock,
  input a,
  output reg p,
  output reg q
);

always @(posedge clock) begin
  case ({a,p,q})
    3'b000: begin
      p <= 1'b0;
      q <= 1'b0;
    end
    
    3'b100: begin
      p <= 1'b1;
      q <= 1'b0;
    end
    
    3'b101: begin
      p <= 1'b0;
      q <= 1'b0;
    end
    
    3'b110: begin
      p <= 1'b1;
      q <= 1'b0;
    end
    
    3'b111: begin
      p <= 1'b0;
      q <= 1'b1;
    end
    
    default: begin
      p <= 1'b0;
      q <= 1'b0;
    end
  endcase
end
endmodule
