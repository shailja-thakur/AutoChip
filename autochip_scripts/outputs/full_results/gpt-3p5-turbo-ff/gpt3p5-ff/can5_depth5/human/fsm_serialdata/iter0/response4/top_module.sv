module top_module (
  input clk,
  input in,
  input reset,
  output reg [7:0] out_byte,
  output reg done
);

  // State Definitions
  localparam [2:0] IDLE = 3'b000;
  localparam [2:0] START_BIT = 3'b001;
  localparam [2:0] DATA_BITS = 3'b010;
  localparam [2:0] STOP_BIT = 3'b011;

  // State Register
  reg [2:0] state;

  // Counter to keep track of data bits received
  reg [2:0] counter;

  // Register to store received data bits
  reg [7:0] received_byte;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counter <= 0;
      received_byte <= 0;
      done <= 0;
    end else begin
      case (state)
        IDLE:
          if (in == 1'b0) begin
            state <= START_BIT;
            counter <= 0;
            received_byte <= 0;
            done <= 0;
          end else begin
            state <= IDLE;
            done <= 0;
          end
        START_BIT:
          if (counter == 8) begin
            state <= STOP_BIT;
            done <= 0;
          end else begin
            state <= DATA_BITS;
            counter <= counter + 1;
            received_byte <= {received_byte[6:0], in};
            done <= 0;
          end
        DATA_BITS:
          if (counter == 8) begin
            state <= STOP_BIT;
            done <= 0;
          end else begin
            state <= DATA_BITS;
            counter <= counter + 1;
            received_byte <= {received_byte[6:0], in};
            done <= 0;
          end
        STOP_BIT:
          if (in == 1'b1) begin
            state <= IDLE;
            out_byte <= received_byte;
            done <= 1;
          end else begin
            state <= STOP_BIT;
            done <= 0;
          end
        default:
          state <= IDLE;
          done <= 0;
      endcase
    end
  end
  
endmodule
