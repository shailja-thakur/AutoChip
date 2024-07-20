module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  reg [2:0] state;
  reg done_next;
  reg byte1_received;
  reg byte2_received;
  reg [2:0] check_state;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
      done_next <= 1'b0;
      byte1_received <= 1'b0;
      byte2_received <= 1'b0;
      check_state <= 3'b000;
    end else begin
      case (state)
        3'b000: begin // Idle state
          if (in[3]) begin  // Check if byte 1 of a message
            state <= 3'b001;
            byte1_received <= 1'b1;
          end
        end
        3'b001: begin // Byte 1 received
          if (in[3] && !byte1_received) begin  // Check if byte 2 of a message
            state <= 3'b010;
            byte2_received <= 1'b1;
          end else if (!in[3] && byte1_received) begin  // Reset if byte 1 is not received
            state <= 3'b000;
            byte1_received <= 1'b0;
          end
        end
        3'b010: begin // Byte 2 received
          if (in[3] && byte1_received && !byte2_received) begin  // Check if byte 3 of a message
            state <= 3'b011;
            done_next <= 1'b1;
          end else if (!in[3] && byte1_received) begin  // Reset if byte 1 is not received
            state <= 3'b000;
            byte1_received <= 1'b0;
          end
        end
        3'b011: begin // Byte 3 received
          state <= 3'b000; // Go back to idle state
          byte1_received <= 1'b0;
          byte2_received <= 1'b0;
          done_next <= 1'b0;
        end
      endcase
    end
  end

  assign done = done_next;

  always @(posedge clk) begin
    check_state <= state; // Store the current state in check_state
  end

  initial begin
    // Simulate input byte stream
    in <= 8'b00000001;  // Start of first message
    #10;
    in <= 8'b00000010;
    #10;
    in <= 8'b10000011;
    #10;
    in <= 8'b00000001;  // Start of second message
    #10;
    in <= 8'b00000010;
    #10;
    in <= 8'b10000011;
    #10;
    in <= 8'b00000001;  // Start of third message
    #10;
    in <= 8'b00000010;
    #10;
    in <= 8'b10000011;
    #10;
    in <= 8'b00000001;  // Start of fourth message
    #10;
    in <= 8'b00000010;
    #10;
    in <= 8'b10000011;
    #10;
    in <= 8'b00000001;  // Start of fifth message
    #10;
    in <= 8'b00000010;
    #10;
    in <= 8'b10000011;
    #10;
    in <= 8'b00000001;  // Start of sixth message
    #10;
    in <= 8'b00000010;
    #10;
    in <= 8'b10000011;
    #10;
    in <= 8'b00000001;  // Start of seventh message
    #10;
    in <= 8'b00000010;
    #10;
    in <= 8'b10000011;
    #10;
    in <= 8'b00000001;  // Start of eighth message
    #10;
    in <= 8'b00000010;
    #10;
    in <= 8'b10000011;
    #10;
    in <= 8'b00000001;  // Start of ninth message
    #10;
    in <= 8'b00000010;
    #10;
    in <= 8'b10000011;
    #10;
    $finish;
  end

endmodule
