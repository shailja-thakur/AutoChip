module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

  reg [2:0] state;
  reg [7:0] byte_1;
  reg [7:0] byte_2;
  reg [7:0] byte_3;
  reg [23:0] message;
  reg done;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
      byte_1 <= 8'b0;
      byte_2 <= 8'b0;
      byte_3 <= 8'b0;
      message <= 24'b0;
      done <= 1'b0;
    end
    else begin
      case (state)
        3'b000: begin
          if (in[3]) begin
            state <= 3'b001;
            byte_1 <= in;
          end
        end
        3'b001: begin
          state <= 3'b010;
          byte_2 <= in;
        end
        3'b010: begin
          state <= 3'b011;
          byte_3 <= in;
        end
        3'b011: begin
          state <= 3'b000;
          message <= {byte_1, byte_2, byte_3};
          done <= 1'b1;
        end
        default: state <= 3'b000;
      endcase
    end
  end

  assign out_bytes = message;

endmodule
