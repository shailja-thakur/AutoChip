module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
  reg [1:0] state; // state register

  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b00; // set state to A
    end else begin
      case(state)
        2'b00: begin // state A
          if (j) begin
            state <= 2'b01; // transition to state B
          end
        end
        2'b01: begin // state B
          if (k) begin
            state <= 2'b00; // transition to state A
          end
        end
      endcase
    end
  end
  
  assign out = (state == 2'b01) ? 1'b1 : 1'b0; // assign output based on state
endmodule
