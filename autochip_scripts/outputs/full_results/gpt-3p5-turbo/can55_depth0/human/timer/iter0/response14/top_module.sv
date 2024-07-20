module top_module(
  input clk,
  input load,
  input [9:0] data,
  output tc
);

  reg [9:0] counter; // Internal counter

  always @(posedge clk) begin
    if(load) begin
      counter <= data; // Load counter with data
    end
    else begin
      if(counter > 0) begin
        counter <= counter - 1; // Decrement counter
      end
      else begin
        counter <= 0; // Counter already reached 0, stay 0 until loaded again
      end
    end
  end

  assign tc = (counter == 0); // Assert tc when counter reaches 0

endmodule
