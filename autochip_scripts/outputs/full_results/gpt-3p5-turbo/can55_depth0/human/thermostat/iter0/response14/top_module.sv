module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

reg fan,autofan,autoac,autoheater;

assign heater = autoheater;
assign aircon = autoac;
assign fan = autofan;  

always@(mode or too_cold or too_hot or fan_on) begin
  case(mode)
    1: begin
      autoheater = too_cold;
      autoac = 0;
    end
    0: begin
      autoheater = 0;
      autoac = too_hot;
    end
    default: begin
      autoheater = 0;
      autoac = 0;
    end
  end
  
  autofan = fan_on || autoheater || autoac;
end

endmodule
