module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  reg [1:0] state;
  reg [23:0] register;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;
      register <= 0;
    end else begin
      case (state)
        2'b00: begin // BYTE1
          if (in[2] == 1'b1) begin
            state <= 2'b01; // BYTE2
            register <= {register[15:0], in};
          end else begin
            state <= 2'b00; // BYTE1
            register <= {register[15:0], in};
          end
        end
        2'b01: begin // BYTE2
          if (in[2] == 1'b1) begin
            state <= 2'b10; // BYTE3
            register <= {register[7:0], in};
          end else begin
            state <= 2'b01; // BYTE2
            register <= {register[7:0], in};
          end
        end
        2'b10: begin // BYTE3
          state <= 2'b11; // DONE
          register <= {register[7:0], in};
        end
        2'b11: begin // DONE
          if (in[2] == 1'b0) begin
            state <= 2'b00; // BYTE1
            register <= {register[7:0], in};
          end else begin
            state <= 2'b11; // DONE
            register <= {register[7:0], in};
          end
        end
      endcase
    end
  end

  assign out_bytes = (done) ? register : 0;
  assign done = (state == 2'b11);

endmodule
