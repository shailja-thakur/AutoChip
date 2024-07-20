module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [2:0] state;
reg [7:0] data;
reg start_bit;
reg stop_bit;
reg [2:0] count;

always @(posedge clk or posedge reset) begin
  if (reset)
    state <= 0;
  else begin
    case (state)
      0: begin
        if (in == 0) begin
          state <= 1;
          start_bit <= 1;
          data <= 0;
          count <= 0;
        end
      end
      1: begin
        start_bit <= 0;
        data[count] <= in;
        count <= count + 1;
        if (count == 7)
          state <= 2;
      end
      2: begin
        stop_bit <= in;
        state <= 3;
      end
      3: begin
        if (in == 1 && stop_bit == 1) begin
          state <= 0;
          done <= 1;
          out_byte <= data;
        end else if (in == 0 && stop_bit == 1)
          state <= 4;
      end
      4: begin
        if (in == 1 && stop_bit == 1) begin
          state <= 0;
          done <= 1;
          out_byte <= data;
        end
      end
    endcase
  end
end

endmodule
