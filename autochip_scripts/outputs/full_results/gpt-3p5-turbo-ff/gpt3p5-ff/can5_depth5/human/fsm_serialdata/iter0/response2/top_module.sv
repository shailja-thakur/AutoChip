module top_module (
  input clk,
  input in,
  input reset,
  output reg [7:0] out_byte,
  output reg done
);

// Define states
parameter IDLE = 3'b000;
parameter START = 3'b001;
parameter DATA = 3'b010;
parameter STOP = 3'b011;

// Define signals
reg [2:0] state;
reg [7:0] data_reg;
reg start_bit_detected;
reg [2:0] bit_counter;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= IDLE;
    data_reg <= 8'b0;
    start_bit_detected <= 1'b0;
    bit_counter <= 3'b0;
    out_byte <= 8'b0;
    done <= 1'b0;
  end else begin
    case (state)
      IDLE: begin
        if (in == 1'b0) begin
          start_bit_detected <= 1'b1;
          bit_counter <= 3'b1;
          state <= START;
        end
      end
      
      START: begin
        if (bit_counter == 3'b100) begin
          if (in == 1'b1) begin
            state <= DATA;
          end else begin
            state <= IDLE;
          end
          bit_counter <= 3'b0;
        end else begin
          if (in == 1'b0) begin
            bit_counter <= bit_counter + 1;
          end else begin
            state <= IDLE;
          end
        end
      end
      
      DATA: begin
        if (bit_counter == 3'b100) begin
          if (in == 1'b1) begin
            state <= STOP;
          end else begin
            state <= IDLE;
          end
          bit_counter <= 3'b0;
        end else begin
          if (in == 1'b0) begin
            data_reg <= {in, data_reg[7:1]};
            bit_counter <= bit_counter + 1;
          end else begin
            state <= IDLE;
          end
        end
      end
      
      STOP: begin
        if (bit_counter == 3'b100) begin
          if (in == 1'b1) begin
            state <= IDLE;
            out_byte <= data_reg;
            done <= 1'b1;
          end else begin
            state <= IDLE;
          end
          bit_counter <= 3'b0;
        end else begin
          if (in == 1'b0) begin
            state <= IDLE;
          end else begin
            bit_counter <= bit_counter + 1;
          end
        end
      end
    endcase
  end
end

endmodule
