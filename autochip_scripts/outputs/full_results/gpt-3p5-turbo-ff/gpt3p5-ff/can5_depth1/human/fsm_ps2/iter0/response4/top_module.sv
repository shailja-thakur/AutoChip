module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [1:0] state;
reg [1:0] next_state;
reg count;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 2'b00;
    done <= 0;
    count <= 4'b0000;
  end else begin
    state <= next_state;
    
    case (state)
      2'b00: 
        if (in[3] == 1) begin
          next_state = 2'b01;
          count <= 4'b0001;
        end else begin
          next_state = 2'b00;
          count <= 4'b0000;
        end
      2'b01: 
        if (count == 4'b0001 && in[3] == 0) begin
          next_state = 2'b00;
          count <= 4'b0000;
        end else if (in[3] == 1) begin
          next_state = 2'b10;
          count <= count + 1;
        end else begin
          next_state = 2'b01;
          count <= count + 1;
        end
      2'b10: 
        if (count == 4'b0011) begin
          next_state = 2'b11;
          count <= 4'b0000;
        end else if (in[3] == 1) begin
          next_state = 2'b10;
          count <= count + 1;
        end else begin
          next_state = 2'b01;
          count <= count + 1;
        end
      2'b11: 
        if (count == 4'b0100) begin
          next_state = 2'b00;
          done <= 1;
          count <= 4'b0000;
        end else if (in[3] == 1) begin
          next_state = 2'b10;
          count <= count + 1;
        end else begin
          next_state = 2'b01;
          count <= count + 1;
        end
      default: 
        next_state = 2'b00;
        count <= 4'b0000;
    endcase
  end
end

endmodule
