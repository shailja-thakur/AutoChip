module top_module (
    input                clk,
    input                reset,
    input                w,
    output               z
);

  reg [2:0] state, next_state;
  wire is_state_A, is_state_B, is_state_C, is_state_D, is_state_E, is_state_F;

  assign is_state_A = (state == 3'b000);
  assign is_state_B = (state == 3'b001);
  assign is_state_C = (state == 3'b010);
  assign is_state_D = (state == 3'b011);
  assign is_state_E = (state == 3'b100);
  assign is_state_F = (state == 3'b101);
  
  always @(posedge clk or posedge reset) begin
    if(reset)
      state <= 0;
    else
      state <= next_state;
  end
  
  always @(*) begin
    case(state)
      3'b000: begin
        if(w)
          next_state = 3'b001;
        else
          next_state = 3'b000;
      end
      3'b001: begin
        if(w)
          next_state = 3'b010;
        else
          next_state = 3'b011;
      end
      3'b010: begin
        if(w)
          next_state = 3'b100;
        else
          next_state = 3'b011;
      end
      3'b011: begin
        if(w)
          next_state = 3'b101;
        else
          next_state = 3'b000;
      end
      3'b100: begin
        if(w)
          next_state = 3'b100;
        else
          next_state = 3'b011;
      end
      3'b101: begin
        if(w)
          next_state = 3'b010;
        else
          next_state = 3'b011;
      end
      default: next_state = 3'b000;
    endcase
  end
  
  always @(posedge clk or posedge reset) begin
    if(reset)
      z <= 0;
    else begin
      case(state)
        3'b000: z <= 1;
        3'b101: z <= 1;
        default: z <= 0;
      endcase
    end
  end
  
endmodule
