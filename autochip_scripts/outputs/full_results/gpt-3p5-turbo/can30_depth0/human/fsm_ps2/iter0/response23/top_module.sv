module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [1:0] state;
reg [2:0] count;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 2'b00;
    count <= 3'b000;
    done <= 0;
  end else begin
    case (state)
      2'b00: begin
        if (in[3]) begin
          state <= 2'b01;
          count <= 3'b001;
        end
      end
      2'b01: begin
        count <= count + 1;
        if (count == 3'b011) begin
          state <= 2'b10;
        end
      end
      2'b10: begin
        state <= 2'b00;
        count <= 3'b000;
        done <= 1;
      end
    endcase
  end
end
  
endmodule
