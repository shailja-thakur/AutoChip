module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  reg [1:0] seqCount;

  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      start_shifting <= 0;
      seqCount <= 0;
    end else begin
      case(state)
        0: begin // Initial state
          if (data) begin
            state <= 1;
            seqCount <= 0;
          end else begin
            state <= 0;
            seqCount <= 0;
          end
        end
        1: begin // State after receiving 1
          if (data) begin
            state <= 1;
            seqCount <= seqCount + 1;
          end else begin
            state <= 2;
            seqCount <= 0;
          end
        end
        2: begin // State after receiving 11
          if (data) begin
            state <= 3;
            seqCount <= 0;
          end else begin
            state <= 0;
            seqCount <= 0;
          end
        end
        3: begin // State after receiving 110
          if (data) begin
            state <= 3;
            seqCount <= seqCount + 1;
          end else begin
            state <= 4;
            seqCount <= 0;
          end
        end
        4: begin // State after receiving 1101
          if (data) begin
            state <= 3;
            seqCount <= seqCount + 1;
          end else begin
            state <= 4;
            seqCount <= 0;
            start_shifting <= 1;
          end
        end
      endcase
    end
  end

endmodule
