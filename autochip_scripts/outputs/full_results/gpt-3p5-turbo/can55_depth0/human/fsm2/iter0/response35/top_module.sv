module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

  // Define states
  parameter OFF = 0;
  parameter ON = 1;
  
  // Define state register and next state
  reg [1:0] state;
  reg [1:0] next_state;
  
  // Define output register
  reg out_reg;
  
  // Asynchronous reset
  always @(posedge areset) begin
    state <= OFF;
    out_reg <= 0;
  end
  
  // Sequential logic
  always @(posedge clk) begin
    if (areset) begin
      state <= next_state;
      out_reg <= out;
    end
    else begin
      state <= next_state;
      case (state)
        OFF: begin
          if (j) begin
            out_reg <= 1;
            next_state <= ON;
          end
          else begin
            out_reg <= 0;
            next_state <= OFF;
          end
        end
        ON: begin
          if (k) begin
            out_reg <= 0;
            next_state <= OFF;
          end
          else begin
            out_reg <= 1;
            next_state <= ON;
          end
        end
      endcase
    end
  end
  
  // Assign output
  assign out = out_reg;

endmodule
