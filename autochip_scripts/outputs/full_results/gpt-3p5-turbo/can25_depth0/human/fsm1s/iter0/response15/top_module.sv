module top_module (
  input clk,
  input in,
  input reset,
  output reg out
);
  reg [1:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b10; // B
      out <= 1'b1;
    end else begin
      case (state)
        2'b10: begin // B
          if (in) begin
            state <= 2'b10; // B
            out <= 1'b1;
          end else begin
            state <= 2'b01; // A
            out <= 1'b0;
          end
        end
        2'b01: begin // A
          if (in) begin
            state <= 2'b01; // A
            out <= 1'b0;
          end else begin
            state <= 2'b10; // B
            out <= 1'b1;
          end
        end
      endcase
    end
  end
endmodule
