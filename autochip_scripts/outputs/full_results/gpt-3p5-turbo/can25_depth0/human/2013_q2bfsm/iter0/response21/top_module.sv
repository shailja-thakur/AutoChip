module top_module (
   input clk,
   input resetn,
   input x,
   input y,
   output f,
   output g
);

   reg [1:0] state, next_state; // FSM states
   reg f_reg, g_reg;
   reg [2:0] x_reg;
   reg [1:0] y_reg;
   
   always @(posedge clk or negedge resetn) begin
      if (!resetn) begin
         state <= 2'b00; // state A
         f_reg <= 1'b0;
         g_reg <= 1'b0;
         x_reg <= 3'b000;
         y_reg <= 2'b00;
      end else begin
         state <= next_state;
         f_reg <= f_reg;
         g_reg <= g_reg;
         x_reg <= {x_reg[1:0], x};
         y_reg <= {y_reg[0], y};
      end
   end
   
   always @(state or x_reg or y_reg) begin
      case (state)
         2'b00: begin // state A
            if (!resetn) begin
               next_state <= 2'b00; // stay in state A
               f <= 1'b0;
               g <= 1'b0;
            end else begin
               next_state <= 2'b01; // transition to state B
               f <= 1'b0;
               g <= 1'b0;
            end
         end
         2'b01: begin // state B
            if (x_reg == 3'b101) begin
               next_state <= 2'b10; // transition to state C
               f <= 1'b1;
               g <= 1'b0;
            end else begin
               next_state <= 2'b01; // stay in state B
               f <= f_reg;
               g <= g_reg;
            end
         end
         2'b10: begin // state C
            if (y_reg == 2'b01) begin
               next_state <= 2'b10; // stay in state C
               f <= f_reg;
               g <= 1'b1;
            end else if (y_reg == 2'b00) begin
               next_state <= 2'b00; // transition to state A
               f <= f_reg;
               g <= 1'b0;
            end else begin
               next_state <= 2'b11; // transition to state D
               f <= f_reg;
               g <= 1'b0;
            end
         end
         2'b11: begin // state D
            next_state <= 2'b10; // transition to state C
            f <= f_reg;
            g <= g_reg;
         end
      endcase
   end

endmodule
