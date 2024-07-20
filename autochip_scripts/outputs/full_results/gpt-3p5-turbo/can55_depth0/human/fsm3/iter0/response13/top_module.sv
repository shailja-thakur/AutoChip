module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg [1:0] state;
  reg [1:0] next_state;

  always @(posedge clk or posedge areset)
  begin
    if (areset)
      state <= 2'b0;
    else
      state <= next_state;
  end

  always @(*)
  begin
    case (state)
      2'b00: begin
               if (in == 1'b0) begin
                 next_state = 2'b00;
                 out = 1'b0;
               end
               else if (in == 1'b1) begin
                 next_state = 2'b01;
                 out = 1'b0;
               end
             end

      2'b01: begin
               if (in == 1'b0) begin
                 next_state = 2'b10;
                 out = 1'b0;
               end
               else if (in == 1'b1) begin
                 next_state = 2'b01;
                 out = 1'b0;
               end
             end

      2'b10: begin
               if (in == 1'b0) begin
                 next_state = 2'b00;
                 out = 1'b0;
               end
               else if (in == 1'b1) begin
                 next_state = 2'b11;
                 out = 1'b0;
               end
             end

      2'b11: begin
               if (in == 1'b0) begin
                 next_state = 2'b10;
                 out = 1'b1;
               end
               else if (in == 1'b1) begin
                 next_state = 2'b01;
                 out = 1'b0;
               end
             end
    endcase
  end
endmodule
