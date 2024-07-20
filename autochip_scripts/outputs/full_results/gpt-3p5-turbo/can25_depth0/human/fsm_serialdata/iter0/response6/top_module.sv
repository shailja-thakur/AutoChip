module top_module (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);

  // Define states
  typedef enum logic [2:0] {
    IDLE,
    START_BIT,
    DATA_BITS,
    STOP_BIT
  } state;

  // Define signals
  reg [2:0] current_state;
  reg [7:0] rx_data;
  reg [2:0] bit_counter;
  reg [7:0] received_byte;
  reg done;

  // State register
  always @(posedge clk, posedge reset) begin
    if (reset) begin
      current_state <= IDLE;
      rx_data <= 8'h00;
      bit_counter <= 3'b000;
      received_byte <= 8'h00;
      done <= 0;
    end
    else begin
      case (current_state)
        IDLE: begin
          if (in == 1'b0) begin
            current_state <= START_BIT;
            rx_data <= 8'h00;
            bit_counter <= 3'b000;
            received_byte <= 8'h00;
            done <= 0;
          end
          else begin
            current_state <= IDLE;
            rx_data <= 8'h00;
            bit_counter <= 3'b000;
            received_byte <= 8'h00;
            done <= 0;
          end
        end
        
        START_BIT: begin
          current_state <= DATA_BITS;
          rx_data <= 8'h00;
		      bit_counter <= 3'b000;
          received_byte <= 8'h00;
          done <= 0;
        end
        
        DATA_BITS: begin
          if (bit_counter == 3'b111) begin
            current_state <= STOP_BIT;
            rx_data <= 8'h00;
            bit_counter <= 3'b000;
            received_byte <= rx_data;
            done <= 1;
          end
          else begin
            current_state <= DATA_BITS;
            rx_data <= {rx_data[6:0], in};
            bit_counter <= bit_counter + 1;
            received_byte <= 8'h00;
            done <= 0;
          end
        end
        
        STOP_BIT: begin
          if (in == 1'b1) begin
            current_state <= IDLE;
            rx_data <= 8'h00;
            bit_counter <= 3'b000;
            received_byte <= 8'h00;
            done <= 0;
          end
          else begin
            current_state <= STOP_BIT;
            rx_data <= 8'h00;
            bit_counter <= 3'b000;
            received_byte <= 8'h00;
            done <= 0;
          end
        end
      endcase
    end
  end

  // Output assignment
  assign out_byte = received_byte;
  assign done = done;

endmodule
