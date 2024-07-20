module top_module (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);

  // State definition
  typedef enum logic [2:0] {
    IDLE,
    START_BIT,
    DATA_BITS,
    STOP_BIT
  } state_t;

  // Internal signals
  reg [2:0] state;
  reg [7:0] data_byte;
  reg [2:0] bit_count;

  // Sequential logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      data_byte <= 8'b0;
      bit_count <= 3'b0;
    end
    else begin
      case (state)
        IDLE:
          if (in == 1'b0) begin
            state <= START_BIT;
            data_byte <= 8'b0;
            bit_count <= 3'b0;
          end
        START_BIT:
          begin
            state <= DATA_BITS;
            data_byte <= 8'b0;
            bit_count <= 3'b0;
          end
        DATA_BITS:
          begin
            if (bit_count == 3'b0) begin
              data_byte <= {data_byte[6:0], in};
              bit_count <= 3'b1;
            end
            else if (bit_count < 3'b8) begin
              data_byte <= {data_byte[6:0], in};
              bit_count <= bit_count + 1'b1;
            end
            else if (bit_count == 3'b8) begin
              state <= STOP_BIT;
              bit_count <= bit_count + 1'b1;
            end
          end
        STOP_BIT:
          begin
            if (in == 1'b1) begin
              state <= IDLE;
              bit_count <= 3'b0;
              out_byte <= data_byte;
              done <= 1'b1;
            end
            else begin
              state <= IDLE;
              bit_count <= 3'b0;
            end
          end
        default:
          state <= IDLE;
      endcase
    end
  end

endmodule
