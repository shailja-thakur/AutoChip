module top_module (
  input clk,
  input in,
  input reset,
  output done
);

  reg [3:0] state;
  reg [7:0] data;
  reg error;
  wire rx_start_bit;
  wire rx_data_bit_0;
  wire rx_data_bit_7;
  wire rx_stop_bit;

  // Start bit detection
  assign rx_start_bit = (state == 0 && in == 0);

  // Data bit detection
  assign rx_data_bit_0 = (state == 1 && in == 1);
  assign rx_data_bit_1 = (state == 2 && in == 1);
  assign rx_data_bit_2 = (state == 3 && in == 1);
  assign rx_data_bit_3 = (state == 4 && in == 1);
  assign rx_data_bit_4 = (state == 5 && in == 1);
  assign rx_data_bit_5 = (state == 6 && in == 1);
  assign rx_data_bit_6 = (state == 7 && in == 1);
  assign rx_data_bit_7 = (state == 8 && in == 1);

  // Stop bit detection
  assign rx_stop_bit = (state == 9 && in == 1);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      data <= 0;
      done <= 0;
      error <= 0;
    end else begin
      case (state)
        0: begin // Start bit
          state <= 1;
          data <= 0;
          error <= 0;
        end
        1: begin // Data bit 0
          state <= 2;
          data <= {data[6:0], in};
          error <= 0;
        end
        2: begin // Data bit 1
          state <= 3;
          data <= {data[5:0], in};
          error <= 0;
        end
        3: begin // Data bit 2
          state <= 4;
          data <= {data[4:0], in};
          error <= 0;
        end
        4: begin // Data bit 3
          state <= 5;
          data <= {data[3:0], in};
          error <= 0;
        end
        5: begin // Data bit 4
          state <= 6;
          data <= {data[2:0], in};
          error <= 0;
        end
        6: begin // Data bit 5
          state <= 7;
          data <= {data[1:0], in};
          error <= 0;
        end
        7: begin // Data bit 6
          state <= 8;
          data <= {data[0], in};
          error <= 0;
        end
        8: begin // Data bit 7
          state <= 9;
          data <= {in, data[7:1]};
          error <= 0;
        end
        9: begin // Stop bit
          if (rx_stop_bit) begin
            state <= 0;
            done <= 1;
            error <= 0;
          end else begin
            state <= 9;
            done <= 0;
            error <= 1;
          end
        end
      endcase
    end
  end

endmodule
