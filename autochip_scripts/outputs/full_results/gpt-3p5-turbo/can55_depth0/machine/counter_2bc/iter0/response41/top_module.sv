module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
  
  // internal registers
  reg [1:0] current_state;
  
  // asynchronous reset
  always @(posedge clk or posedge areset) begin
    if (areset)
      current_state <= 2'b01;
    else if (train_valid) begin
      if (train_taken && current_state < 2'b11)
        current_state <= current_state + 1;
      else if (!train_taken && current_state > 2'b00)
        current_state <= current_state - 1;
    end
  end
  
  // assign output
  assign state = current_state;
  
endmodule
