module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [3:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 1;
    byte1 <= 8'b0;
    byte2 <= 8'b0;
    byte3 <= 8'b0;
  end else begin
    case(state)
      1: begin // Waiting for start of message
        if (in[3] == 1) begin
          state <= 2;
          byte1 <= in;
        end
      end
      
      2: begin // Receiving second byte
        byte2 <= in;
        state <= 3;
      end
      
      3: begin // Receiving third byte
        byte3 <= in;
        state <= 4;
      end
      
      4: begin // Message received
        done <= 1;
        state <= 1;
      end
    endcase
  end
end

endmodule
