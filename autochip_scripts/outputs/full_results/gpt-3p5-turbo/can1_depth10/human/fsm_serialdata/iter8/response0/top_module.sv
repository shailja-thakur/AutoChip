module top_module (
  input clk,
  input in,
  input reset,
  output reg [7:0] out_byte,
  output reg done
);

// Define the states
typedef enum logic [2:0] {
  IDLE,
  START_BIT,
  DATA_BITS,
  STOP_BIT,
  STOP_DETECTED
} state_type;

reg [2:0] state;
reg [7:0] data_byte;
reg [2:0] count;
reg [2:0] stop_count;

always @(posedge clk) begin
  if (reset) begin
    state <= IDLE;
    data_byte <= 8'b0;
    count <= 0;
    stop_count <= 0;
    done <= 0;
  end else begin
    case (state)
      IDLE:
        if (in == 1'b0) begin
          state <= START_BIT;
          count <= 0;
          stop_count <= 0;
        end
      START_BIT:
        if (count < 8) begin
          state <= DATA_BITS;
          data_byte <= {in, data_byte[7:1]};
          count <= count + 1;
          stop_count <= 0;
        end else if (in == 1'b1) begin
          state <= STOP_BIT;
          stop_count <= 0;
        end else begin
          state <= STOP_DETECTED;
          stop_count <= 0;
        end
      DATA_BITS:
        if (count < 7) begin
          state <= DATA_BITS;
          data_byte <= {in, data_byte[7:1]};
          count <= count + 1;
        end else begin
          if (in == 1'b0) begin
            state <= IDLE;
            stop_count <= 0;
          end else begin
            state <= STOP_BIT;
            stop_count <= 0;
          end
        end
      STOP_BIT:
        if (stop_count < 1) begin
          if (in == 1'b1) begin
            stop_count <= stop_count + 1;
          end else begin
            state <= STOP_DETECTED;
            done <= 1;
            out_byte <= data_byte;
          end
        end else begin
          state <= STOP_DETECTED;
          stop_count <= 0;
        end
      STOP_DETECTED:
        if (in == 1'b1) begin
          state <= IDLE;
        end
    endcase
  end
end

endmodule
