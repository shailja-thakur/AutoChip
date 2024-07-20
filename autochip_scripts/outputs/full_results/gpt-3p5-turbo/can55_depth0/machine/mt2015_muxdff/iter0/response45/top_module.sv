module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
    );

// Define local wire for selecting input
wire select;

// Assign select based on input L
assign select = L ? r_in : q_in;

// Synchronous always block triggered on rising edge of clk
always @(posedge clk)
    begin
        // Assign output Q with selected input
        Q <= select;
    end
    
endmodule
