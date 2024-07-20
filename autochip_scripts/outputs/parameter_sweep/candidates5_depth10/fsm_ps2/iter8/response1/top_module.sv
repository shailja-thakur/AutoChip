module top_module (
   input clk,
   input [7:0] in,
   input reset,
   output reg done
);

   reg [2:0] state;
   reg [1:0] count;
   wire is_first_byte;
   wire is_in_valid;
   reg [7:0] prev_in;

  assign is_first_byte = in[3];
  assign is_in_valid = (prev_in[3] == 1) & (in[3] == 0); // Detect falling edge of in[3]

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      count <= 0;
      done <= 0;
    end else begin
      case (state)
        0: begin
          if (is_first_byte) begin
            state <= 1;
            count <= 0;
          end
        end
        1: begin
          if (is_first_byte) begin
            state <= 2;
            count <= 0;
          end else begin
            state <= 0;
            count <= 0;
          end
        end
        2: begin
          if (is_first_byte) begin
            state <= 1;
            count <= count + 1;
          end else begin
            if (count == 1) begin
              state <= 0;
              count <= 0;
              done <= 1;
            end else begin
              count <= count + 1;
            end
          end
        end
      endcase
      prev_in <= in;
    end
  end

endmodule
