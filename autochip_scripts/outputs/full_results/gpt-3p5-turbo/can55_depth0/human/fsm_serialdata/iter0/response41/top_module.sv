module top_module (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);

  reg [2:0] state;
  reg [7:0] data;
  reg start_detected;
  reg [2:0] count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'd0;
      data <= 8'd0;
      start_detected <= 1'b0;
      count <= 3'd0;
      done <= 1'b0;
      out_byte <= 8'd0;
    end else begin
      case (state)
        3'd0: begin
          if (in == 1'b0) begin
            state <= 3'd1;
            start_detected <= 1'b1;
          end
        end
        3'd1: begin
          if (start_detected) begin
            data[count] <= in;
            count <= count + 1;
            if (count == 3'd7) begin
              state <= 3'd2;
            end
          end
        end
        3'd2: begin
          if ((in == 1'b1) && (count == 3'd7)) begin
            state <= 3'd3;
            done <= 1'b1;
            out_byte <= data;
          end else if ((in == 1'b1) && (count != 3'd7)) begin
            state <= 3'd0;
          end
        end
        3'd3: begin
          if (in == 1'b0) begin
            state <= 3'd0;
          end
        end
      endcase
    end
  end

endmodule
