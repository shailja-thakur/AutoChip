module top_module (
    input clk,
    input reset,
    input w,
    output z
);
  
  reg [2:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'h0;
    else begin
      case(state)
        3'h0: if(w) state <= 3'h1; else state <= 3'h2;
        3'h1: if(w) state <= 3'h0; else state <= 3'h3;
        3'h2: if(w) state <= 3'h3; else state <= 3'h4;
        3'h3: if(w) state <= 3'h0; else state <= 3'h5;
        3'h4: if(w) state <= 3'h5; else state <= 3'h6;
        3'h5: if(w) state <= 3'h3; else state <= 3'h5;
        3'h6: if(w) state <= 3'h2; else state <= 3'h5;
        default: state <= 3'h0;
      endcase
    end
  end
  
  assign z = (state == 3'h6);
endmodule
