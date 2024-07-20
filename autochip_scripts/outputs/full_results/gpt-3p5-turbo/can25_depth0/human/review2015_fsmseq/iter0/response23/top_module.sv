module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting
);

// Internal Signals
reg [2:0] state;
reg found_sequence;

// State definition
parameter IDLE = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;

// Next State and Output Logic
always @(posedge clk, posedge reset) begin
  if(reset) begin
    state <= IDLE;
    found_sequence <= 0;
  end else begin
    case(state)
      IDLE: begin
        if(data) begin
          state <= S1;
          found_sequence <= 0;
        end
      end
      
      S1: begin
        if(data) begin
          state <= S1;
          found_sequence <= 0;
        end else begin
          state <= S2;
          found_sequence <= 0;
        end
      end
      
      S2: begin
        if(data) begin
          state <= S1;
          found_sequence <= 0;
        end else begin
          state <= S3;
          found_sequence <= 0;
        end
      end
      
      S3: begin
        if(data) begin
          state <= S1;
          found_sequence <= 1;
          start_shifting <= 1;
        end
      end
    endcase
  end
end

endmodule
