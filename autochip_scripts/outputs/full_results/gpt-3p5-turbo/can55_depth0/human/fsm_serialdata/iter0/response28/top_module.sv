module top_module (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);
  
  reg [2:0] state;
  reg [7:0] data_byte;
  reg start_flag;
 
  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000; // idle state
      data_byte <= 8'b0;
      start_flag <= 1'b0;
      done <= 1'b0;
    end 
    else begin
      case (state)
        3'b000: begin // idle state
          if (in == 1'b0) begin
            state <= 3'b001; // start bit detected
            start_flag <= 1'b1;
          end
          else begin
            state <= 3'b000; // stay in idle state
            start_flag <= 1'b0;
          end
        end
        3'b001: begin // start bit detected
          if (in == 1'b0) begin
            state <= 3'b010; // receive data bits
          end
          else begin
            state <= 3'b000; // start bit not detected, return to idle state
          end
        end
        3'b010: begin // receive data bits
          if (in == 1'b0) begin
            data_byte <= {data_byte[6:0], in};
          end
          else begin
            state <= 3'b011; // data bits received, wait for stop bit
          end
        end
        3'b011: begin // wait for stop bit
          if (in == 1'b1) begin
            if (start_flag) begin
              state <= 3'b100; // receive stop bit
            end
            else begin
              state <= 3'b000; // start bit not detected, return to idle state
            end
          end
          else begin
            state <= 3'b011; // stay in wait for stop bit state
          end
        end
        3'b100: begin // receive stop bit
          if (in == 1'b1) begin
            state <= 3'b000; // byte received, return to idle state
            done <= 1'b1;
            out_byte <= data_byte;
          end
          else begin
            state <= 3'b011; // stop bit not detected, return to wait for stop bit state
          end
        end
      endcase
    end
  end
endmodule
