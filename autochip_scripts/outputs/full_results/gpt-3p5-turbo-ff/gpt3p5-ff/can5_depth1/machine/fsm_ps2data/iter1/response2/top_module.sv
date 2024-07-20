module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  reg [2:0] state;
  reg [23:0] register;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
      register <= 0;
    end else begin
      case (state)
        3'b000: begin // BYTE1
          if (in[2] == 1'b1) begin
            state <= 3'b001; // BYTE2
            register <= {register[15:0], in};
          end else begin
            state <= 3'b011; // DONE
            register <= {register[15:0], in};
          end
        end
        3'b001: begin // BYTE2
          if (in[2] == 1'b1) begin
            state <= 3'b010; // BYTE3
            register <= {register[7:0], in};
          end else begin
            state <= 3'b001; // BYTE2
            register <= {register[7:0], in};
          end
        end
        3'b010: begin // BYTE3
          state <= 3'b011; // DONE
          register <= {register[7:0], in};
        end
        3'b011: begin // DONE
          if (in[2] == 1'b0) begin
            state <= 3'b000; // BYTE1
            register <= {register[7:0], in};
          end else begin
            state <= 3'b011; // DONE
            register <= {register[7:0], in};
          end
        end
      endcase
    end
  end

  assign out_bytes = register; // Assign out_bytes directly from register
  assign done = (state == 3'b011);

endmodule
