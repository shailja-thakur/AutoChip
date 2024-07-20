module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
  
  // Declare state signals
  reg [1:0] state;
  
  // State encoding
  localparam A = 2'b00;
  localparam B = 2'b01;
  
  // Default assignments
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= A;
      z <= 0;
    end 
    else begin
      case(state)
        A: begin
          if (s == 1'b1) begin
            state <= B;
          end
        end
        B: begin
          if (w == 1'b1) begin
            state <= A;
            z <= 1;
          end
        end
      endcase
    end
  end

endmodule
