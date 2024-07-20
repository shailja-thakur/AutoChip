module top_module ( 
    input [255:0] in, 
    input [7:0] sel, 
    output out 
); 
  wire [255:0] sel_mux; 
  always @(*) 
  begin 
    case (sel) 
      8'b00000000: sel_mux = in[0]; 
      8'b00000001: sel_mux = in[1]; 
      8'b00000010: sel_mux = in[2]; 
      8'b00000011: sel_mux = in[3]; 
      // continue assigning sel_mux values up to sel = 255 
      default: sel_mux = 0; 
    endcase 
    out = sel_mux; 
  end 
endmodule
