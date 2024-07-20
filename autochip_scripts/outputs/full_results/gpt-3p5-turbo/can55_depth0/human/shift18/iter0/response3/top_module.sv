module top_module(
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q);
  
  always @(posedge clk) begin
    // Load data into the shift register if load signal is high
    if (load) begin
      q <= data;
    end
    // Shift the data based on the amount signal if ena signal is high
    else if (ena) begin
      case (amount)
        2'b00: q <= {q[62:0], q[63]};
        2'b01: q <= {q[55:0], data[63:56]};
        2'b10: q <= {q[0], q[63:1]};
        2'b11: q <= {data[7:0], q[63:8]};
      endcase
    end
  end
  
endmodule
