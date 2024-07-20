module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

  reg [1:0] state;     // state variable to store the current state
  reg out_reg;        // output register
  
  always @(posedge clk) begin
    if (reset) begin        // check for reset
      state <= 2'b00;       // reset to state OFF
      out_reg <= 1'b0;      // output is 0 in OFF state
    end
    else begin
      case (state)
        2'b00: begin       // OFF state
          if (j) begin     // transition condition (j=1)
      	    state <= 2'b01;      // move to ON state
            out_reg <= 1'b0;     // set output as 0 in ON state
          end
          else begin
            state <= 2'b00;    // remain in OFF state
          end
        end
        2'b01: begin       // ON state
          if (k) begin     // transition condition (k=1)
            state <= 2'b00;      // move to OFF state
            out_reg <= 1'b1;     // set output as 1 in OFF state
          end
          else begin
            state <= 2'b01;    // remain in ON state
          end
        end
      endcase
    end
  end

  assign out = out_reg;     // assign output value

endmodule
