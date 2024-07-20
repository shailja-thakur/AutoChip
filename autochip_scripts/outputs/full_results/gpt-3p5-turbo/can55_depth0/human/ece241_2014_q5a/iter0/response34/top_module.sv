module top_module (
  input clk,
  input areset,
  input x,
  output reg[31:0] z
);

reg[1:0] state;
reg[31:0] tmp_z;
reg[31:0] tmp_x;

always @(posedge clk or (areset==1)) begin
  if(areset == 1) begin
    state <= 2'b00;
    tmp_z <= 0;
    tmp_x <= 0;
    z <= 0;
  end else begin
    case(state)
      2'b00: begin
        if(x == 1) begin
          tmp_x <= tmp_x + 1;
        end
        tmp_z <= tmp_x;
        state <= 2'b01;
      end
      2'b01: begin
        tmp_z <= tmp_z + 1;
        state <= 2'b10;
      end
      2'b10: begin
        if(x == 1) begin
          tmp_x <= tmp_x + 1;
        end
        tmp_z <= tmp_x;
        state <= 2'b01;
      end
    endcase
    z <= tmp_z;
  end
end

endmodule
