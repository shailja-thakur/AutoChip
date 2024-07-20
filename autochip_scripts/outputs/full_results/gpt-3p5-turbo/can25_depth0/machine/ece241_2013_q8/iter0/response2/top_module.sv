module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

  reg [1:0] state, state_next;
  
  always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
      state <= 2'b0;
    end else begin
      state <= state_next;
    end
  end
  
  always @(state or x) begin
    case (state)
      2'b00:
        if (x == 1'b0) begin
          state_next = 2'b00;
        end else begin
          state_next = 2'b01;
        end
      2'b01:
        if (x == 1'b0) begin
          state_next = 2'b10;
        end else begin
          state_next = 2'b01;
        end
      2'b10:
        if (x == 1'b0) begin
          state_next = 2'b00;
        end else begin
          state_next = 2'b01;
        end
      default:
        state_next = 2'b00;
    endcase
  end
  
  always @(state) begin
    case (state)
      2'b00, 2'b01:
        z = 1'b0;
      2'b10:
        z = x;
      default:
        z = 1'b0;
    endcase
  end
    
endmodule
