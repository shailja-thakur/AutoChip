module top_module(
  input clk,
  input areset,
  input train_valid,
  input train_taken,
  output logic [1:0] state
);

  // Internal signals
  reg [1:0] counter;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // Reset counter to weakly not-taken
      counter <= 2'b01;
    end else if (train_valid) begin
      if (train_taken) begin
        // Increment counter
        counter <= (counter == 2'b11) ? 2'b11 : counter + 1;
      end else begin
        // Decrement counter
        counter <= (counter == 2'b00) ? 2'b00 : counter - 1;
      end
    end
  end

  assign state = counter;
endmodule
