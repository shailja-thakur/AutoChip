module top_module (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);

  reg [3:0] state;
  reg [7:0] data_byte;
  reg start_bit_found;
  reg [2:0] bit_count;
  
  parameter IDLE = 2'd0;
  parameter START = 2'd1;
  parameter DATA = 2'd2;
  parameter STOP = 2'd3;
  
  always @(posedge clk, negedge reset) begin
    if (reset == 1'b0) begin
      state <= IDLE;
      data_byte <= 8'b0;
      start_bit_found <= 1'b0;
      bit_count <= 3'd0;
    end else begin
      case (state)
        IDLE: begin
          if (in == 1'b0) begin
            start_bit_found <= 1'b1;
            state <= START;
          end else begin
            start_bit_found <= 1'b0;
            state <= IDLE;
          end
        end
        START: begin
          if (bit_count < 3'd8) begin
            data_byte <= {data_byte[6:0], in};
            bit_count <= bit_count + 1'd1;
            state <= DATA;
          end else begin
            state <= STOP;
          end
        end
        DATA: begin
          if (bit_count < 3'd8) begin
            data_byte <= {data_byte[6:0], in};
            bit_count <= bit_count + 1'd1;
            state <= DATA;
          end else begin
            state <= STOP;
          end
        end
        STOP: begin
          if (in == 1'b1) begin
            done <= 1'b1;
            out_byte <= data_byte;
            state <= IDLE;
          end else begin
            done <= 1'b0;
            state <= STOP;
          end
        end
        default: begin
          state <= IDLE;
        end
      endcase
    end
  end

endmodule
