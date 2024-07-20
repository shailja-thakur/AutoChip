module top_module (
    input clk,
    input in,
    input reset,
    output done
);

  reg [2:0] state;
  reg [7:0] data;
  reg start_detected;
  
  always @(posedge clk) begin
    if (reset == 1) begin
      state <= 3'b000;
      data <= 8'b0;
      start_detected <= 0;
    end else begin
      case (state)
        3'b000: begin // Idle state
          if (in == 1) begin
            state <= 3'b001; // Start bit detected
            data <= 8'b0;
            start_detected <= 1;
          end
        end
        3'b001: begin // Start bit detected state
          if (in == 0 && start_detected == 1) begin
            state <= 3'b010; // Data receiving state
          end else if (in == 1) begin
            state <= 3'b000; // False start bit detected, return to idle
            start_detected <= 0;
          end
        end
        3'b010: begin // Data receiving state
          data <= {data[6:0], in}; // Shift in data bit
          if (start_detected == 1 && data == 8'b11111111) begin
            // All data bits received, wait for stop bit
            state <= 3'b011;
          end
        end
        3'b011: begin // Stop bit detecting state
          if (in == 1) begin
            state <= 3'b100; // Stop bit detected
          end
        end
        3'b100: begin // Stop bit detected state
          state <= 3'b000; // Return to idle
          start_detected <= 0;
        end
      endcase
    end
  end
  
  assign done = (state == 3'b100);
  
endmodule
