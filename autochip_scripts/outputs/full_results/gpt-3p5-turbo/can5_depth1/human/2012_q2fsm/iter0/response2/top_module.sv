module fsm_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
    end
    else begin
      case(state)
        3'b000: begin // State A
          if (w) state <= 3'b010; // Transition A->B on input 1
          else state <= 3'b000; // Stay in state A on input 0
        end
        3'b010: begin // State B
          if (w) state <= 3'b100; // Transition B->C on input 1
          else state <= 3'b110; // Transition B->D on input 0
        end
        3'b100: begin // State C
          if (w) state <= 3'b101; // Transition C->E on input 1
          else state <= 3'b110; // Transition C->D on input 0
        end
        3'b110: begin // State D
          if (w) state <= 3'b111; // Transition D->F on input 1
          else state <= 3'b000; // Transition D->A on input 0
        end
        3'b001: begin // State E
          if (w) state <= 3'b001; // Stay in state E on input 1
          else state <= 3'b110; // Transition E->D on input 0
        end
        3'b111: begin // State F
          if (w) state <= 3'b100; // Transition F->C on input 1
          else state <= 3'b110; // Transition F->D on input 0
        end
      endcase
    end
  end

  always @(posedge clk) begin
    case(state)
      3'b000: z <= 1'b0; // Output z is 0 in state A
      3'b010: z <= 1'b0; // Output z is 0 in state B
      3'b100: z <= 1'b0; // Output z is 0 in state C
      3'b110: z <= 1'b0; // Output z is 0 in state D
      3'b001: z <= 1'b1; // Output z is 1 in state E
      3'b111: z <= 1'b1; // Output z is 1 in state F
    endcase
  end

endmodule
module top_module (
  input clk,
  input reset,
  input w,
  output z
);

  fsm_module fsm_inst(
    .clk(clk),
    .reset(reset),
    .w(w),
    .z(z)
  );

endmodule
