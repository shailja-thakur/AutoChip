module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    // Declare internal wires and registers
    wire [511:0] q_next;
    
    // Create system always block
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= q_next;
        end
    end
    
    // Generate next state of q
    genvar i;
    generate
        for (i = 0; i < 512; i = i + 1) begin
            always @(*) begin
                if (i == 0) begin
                    q_next[i] = (q[i+1] & q[i]) ^ 0;
                end else if (i == 511) begin
                    q_next[i] = (q[i-1] & q[i]) ^ 0;
                end else begin
                    q_next[i] = (q[i-1] & q[i]) ^ 0;
                end
            end
        end
    endgenerate
    
endmodule
