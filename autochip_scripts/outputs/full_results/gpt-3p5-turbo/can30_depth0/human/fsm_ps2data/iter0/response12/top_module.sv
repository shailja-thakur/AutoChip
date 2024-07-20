module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

reg [7:0] prev_byte;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

reg start;
reg [2:0] state;

parameter S_IDLE = 0;
parameter S_WAIT_START = 1;
parameter S_WAIT_BYTE1 = 2;
parameter S_WAIT_BYTE2 = 3;
parameter S_WAIT_BYTE3 = 4;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    out_bytes <= 0;
    done <= 0;
    start <= 0;
    state <= S_IDLE;
    prev_byte <= 0;
    byte1 <= 0;
    byte2 <= 0;
    byte3 <= 0;
  end else begin
    start <= in[3];

    case (state)
      S_IDLE:
        if (start) begin
          state <= S_WAIT_START;
        end
        
      S_WAIT_START:
        if (!start) begin
          byte1 <= in;
          state <= S_WAIT_BYTE1;
        end
        
      S_WAIT_BYTE1:
        if (start) begin
          state <= S_WAIT_START;
        end else begin
          byte2 <= in;
          state <= S_WAIT_BYTE2;
        end
        
      S_WAIT_BYTE2:
        if (start) begin
          state <= S_WAIT_START;
        end else begin
          byte3 <= in;
          state <= S_WAIT_BYTE3;
        end
        
      S_WAIT_BYTE3:
        if (start) begin
          state <= S_WAIT_START;
          out_bytes <= {byte1, byte2, byte3};
          done <= 1;
        end
    endcase

    if (done) begin
      out_bytes <= 0;
      done <= 0;
    end
  end
end

endmodule
