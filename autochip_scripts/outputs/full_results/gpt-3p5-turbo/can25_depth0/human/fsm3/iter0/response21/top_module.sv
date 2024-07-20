module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg [1:0] state;
  reg [1:0] next_state;
  reg out_reg;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b00;
    end
    else begin
      state <= next_state;
    end
  end
  
  always @(state, in) begin
    case(state)
      2'b00: begin // state A
        if (in) begin
          next_state <= 2'b01; // next state B
        end
        else begin
          next_state <= 2'b00; // next state A
        end
        out_reg <= 1'b0;
      end
      2'b01: begin // state B
        if (in) begin
          next_state <= 2'b01; // next state B
        end
        else begin
          next_state <= 2'b10; // next state C
        end
        out_reg <= 1'b0;
      end
      2'b10: begin // state C
        if (in) begin
          next_state <= 2'b11; // next state D
        end
        else begin
          next_state <= 2'b00; // next state A
        end
        out_reg <= 1'b0;
      end
      2'b11: begin // state D
        if (in) begin
          next_state <= 2'b01; // next state B
        end
        else begin
          next_state <= 2'b10; // next state C
        end
        out_reg <= 1'b1;
      end
    endcase
  end
  
  always @(posedge clk) begin
    out <= out_reg;
  end
  
endmodule
