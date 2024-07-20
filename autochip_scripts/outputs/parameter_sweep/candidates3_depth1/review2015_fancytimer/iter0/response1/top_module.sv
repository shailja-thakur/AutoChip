module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output reg [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);

  reg [3:0] delay;
  reg [3:0] state;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 4'b0000;
      counting <= 0;
      done <= 0;
      count <= 4'bxxxx;
      delay <= 4'b0000;
    end else begin
      case(state)
        4'b0000: begin // Start searching for input sequence 1101
          if (data == 4'b1101) begin
            state <= 4'b0001;
            counting <= 0;
            done <= 0;
            count <= 4'bxxxx;
          end
        end
        
        4'b0001: begin // Shift in next 4 bits to determine delay
          delay <= data[3:0];
          state <= 4'b0010;
        end
        
        4'b0010: begin // Start counting and wait for (delay+1) * 1000 clock cycles
          counting <= 1;
          if (count == delay) begin
            done <= 1;
            state <= 4'b0011;
            count <= delay;
          else if (count > 0)
            count <= count - 1;
          else
            count <= 4'bxxxx;
        end
        
        4'b0011: begin // Wait for ack to reset and look for start sequence
          counting <= 0;
          if (ack) begin
            state <= 4'b0000;
            done <= 0;
            count <= 4'bxxxx;
          end
        end
      endcase
    end
  end

endmodule
