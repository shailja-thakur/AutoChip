module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  // Define states
  parameter BYTE1 = 2'b00;
  parameter BYTE2 = 2'b01;
  parameter BYTE3 = 2'b10;
  parameter DONE = 2'b11;
  
  reg [1:0] state_reg;
  reg [1:0] state_next;
  
  always @(posedge clk, posedge reset) begin
    if (reset) begin
      state_reg <= BYTE1;
    end else begin
      state_reg <= state_next;
    end
  end
  
  always @(*) begin
    state_next = state_reg;
    
    case (state_reg)
      BYTE1: begin
        if (in[2]) begin
          state_next = BYTE2;
        end
      end
      
      BYTE2: begin
        state_next = BYTE3;
      end
      
      BYTE3: begin
        state_next = DONE;
      end
      
      DONE: begin
        if (in[2] == 0) begin
          state_next = BYTE1;
        end else begin
          state_next = BYTE2;
        end
      end
    endcase
  end
  
  assign done = (state_reg == DONE);

endmodule
