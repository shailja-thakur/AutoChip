module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

  // Define the states
  typedef enum logic [1:0] {
    BYTE1, BYTE2, BYTE3, DONE
  } state_t;

  // Declare state and next state variables
  reg state_t state, next_state;

  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      state <= BYTE1;
    end else begin
      state <= next_state;
    end
  end

  always @* begin
    next_state = state;
    done = 0;
    case (state)
      
      BYTE1: begin
        if (in[2] == 1'b1) begin
          next_state = BYTE2;
        end
        out_bytes <= {out_bytes[15:0], in};
      end

      BYTE2: begin
        next_state = BYTE3;
        out_bytes <= {out_bytes[15:0], in};
      end

      BYTE3: begin
        next_state = DONE;
        out_bytes <= {out_bytes[15:0], in};
      end

      DONE: begin
        if (in[2] == 1'b0) begin
          next_state = BYTE1;
        end
        out_bytes <= {out_bytes[15:0], in};
        done = 1;
      end
      
    endcase
  end

endmodule
