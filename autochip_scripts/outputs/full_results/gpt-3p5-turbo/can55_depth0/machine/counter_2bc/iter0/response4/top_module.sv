module top_module(
  input clk,
  input areset,
  input train_valid,
  input train_taken,
  output logic [1:0] state
);

  // Define the states
  parameter S0 = 2'b00;
  parameter S1 = 2'b01;
  parameter S2 = 2'b10;
  parameter S3 = 2'b11;

  // Define the state register
  logic [1:0] current_state;

  // Synchronous reset to state S1
  always_ff @(posedge clk) begin
    if (areset) begin
      current_state <= S1;
    end else begin
      case(current_state)
        S0: begin
          if (train_taken && (current_state < S3))
            current_state <= S1;
        end
        S1: begin
          if (train_valid)
            current_state <= train_taken ? S2 : current_state;
        end
        S2: begin
          if (train_taken && (current_state < S3))
            current_state <= S3;
          else if (!train_taken)
            current_state <= S1;
        end
        S3: begin
          if (!train_taken)
            current_state <= S2;
        end
      endcase
    end
  end

  // Assign the state output
  assign state = current_state;

endmodule
