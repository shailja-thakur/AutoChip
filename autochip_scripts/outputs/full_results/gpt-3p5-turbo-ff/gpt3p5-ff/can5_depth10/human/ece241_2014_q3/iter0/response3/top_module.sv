module top_module (
	input c,
	input d,
	output [3:0] mux_in
); 

    wire not_d;
    assign not_d = ~d;
    
    wire[3:0] mux_out;
    
    // First 2-to-1 multiplexer
    wire mux0_out;
    assign mux0_out = (c & d) ? 1'b0 : 1'b1;
    
    // Second 2-to-1 multiplexer
    wire mux1_out;
    assign mux1_out = (c & not_d) ? 1'b1 : 1'b0;
    
    // Third 2-to-1 multiplexer
    wire mux2_out;
    assign mux2_out = (c & d) ? 1'b1 : 1'b0;
    
    // Fourth 2-to-1 multiplexer
    wire mux3_out;
    assign mux3_out = (c & d) ? 1'b1 : 1'b0;
    
    // 4-to-1 multiplexer
    assign mux_in[0] = (mux0_out & ~d) | (mux1_out & d);
    assign mux_in[1] = (mux0_out & d) | (mux1_out & ~d);
    assign mux_in[2] = (mux2_out & ~d) | (mux3_out & d);
    assign mux_in[3] = (mux2_out & d) | (mux3_out & ~d);
    
endmodule
