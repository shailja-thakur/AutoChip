module top_module (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);

  reg [7:0] data_reg;
  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      state <= 0;
      data_reg <= 8'b0;
      done <= 0;
    end else begin
      case(state)
        0: begin // Idle state
          if(in == 1'b0) begin
            state <= 1; // Move to start bit state
            data_reg <= 8'b0;
          end
        end
        1: begin // Start bit state
          if(in == 1'b1) begin
            state <= 2; // Move to data bit state
          end
        end
        2: begin // Data bit state
          data_reg <= {data_reg[6:0], in}; // Shift in data bit
          state <= (state == 9) ? 3 : state + 1; // Check for last data bit
        end
        3: begin // Stop bit state
          if(in == 1'b1) begin
            state <= 0; // Move back to idle state
            out_byte <= data_reg; // Output received data byte
            done <= 1; // Signal byte reception is complete
          end
        end
      endcase
    end
  end
endmodule
