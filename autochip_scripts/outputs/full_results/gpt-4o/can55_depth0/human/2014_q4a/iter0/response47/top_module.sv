module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    wire mux1_out, mux2_out;
    
    // First multiplexer: Select between load value (R) or the input to the shift register stage (w)
    assign mux1_out = (L) ? R : w;
    
    // Second multiplexer: Enable shifting or hold the current value
    assign mux2_out = (E) ? mux1_out : Q;
    
    // D Flip-Flop: Update the output Q on the positive edge of the clock
    always @(posedge clk) begin
        Q <= mux2_out;
    end
endmodule
