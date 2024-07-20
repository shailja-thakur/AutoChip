module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
    reg [3:0] d; // D input for each flip flop
    reg [3:0] q; // Q output for each flip flop
    wire [3:0] q_next;
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            q <= 4'b0; // Reset the output to 0
        end else begin
            q <= q_next; // Assign next value of Q to Q output on positive clock edge
        end
    end
    
    assign out = q[0];
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            d <= 4'b0; // Reset all inputs to 0
        end else begin
            d <= {d[2:0], in}; // Shift in the new input into the shift register
        end
    end
    
    always @* begin
        q_next[0] <= d[0];
        q_next[1] <= d[1];
        q_next[2] <= d[2];
        q_next[3] <= d[3];
    end
endmodule
