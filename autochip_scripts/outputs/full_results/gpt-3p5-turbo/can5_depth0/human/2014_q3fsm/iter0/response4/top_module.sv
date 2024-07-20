module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);
  reg [1:0] state; // state variable
  
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      state <= 2'b00; // reset state A
      z <= 0; // output z is initialized to 0
    end
    else begin
      case(state)
        2'b00: begin // state A
          if(s == 1)
            state <= 2'b01; // move to state B
        end
        2'b01: begin // state B
          if(w == 1) begin
            if({w, w, ~w} == 3'b110) // check if w = 1 in exactly two out of three clock cycles
              z <= 1; // set z to 1
            else
              z <= 0; // set z to 0
          end
          state <= 2'b00; // move back to state A
        end
      endcase
    end
  end

endmodule
