module top_module(
    input ring, 
    input vibrate_mode,
    output reg ringer,
    output reg motor
);
	
	always @(*) begin
		// ringer output control
        if (ring && !vibrate_mode) begin
            ringer = 1;
        end else begin
            ringer = 0;
        end
        
		// motor output control
        if (ring && vibrate_mode) begin
            motor = 1;
        end else begin
            motor = 0;
        end
    end
    
endmodule
