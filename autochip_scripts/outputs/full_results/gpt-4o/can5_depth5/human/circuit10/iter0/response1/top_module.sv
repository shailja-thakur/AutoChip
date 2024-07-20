module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

// Internal register to hold the state of the flip-flop
reg ff;

always @(posedge clk) begin
    // Update flip-flop (ff) and state based on inputs 'a' and 'b'
    if(a & b) begin
        ff <= 0;
    end 
    else if(a & ~b) begin
        ff <= 1;
    end
    else if(~a & b) begin
        ff <= ff; // Maintain the same state when a=0, b=0 or a=0,b=1
    end
    else if(~a & ~b) begin
        ff <= ff;
    end
    state <= ff; // Output the state of the flip-flop
end

assign q = ff;

endmodule
