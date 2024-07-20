module top_module(
    input clk,
    input d,
    output reg q);
    
    reg q_pos, q_neg;
    
    // Positive edge triggered D flip-flop
    always @(posedge clk) begin
        q_pos <= d;
    end
    
    // Negative edge triggered D flip-flop
    always @(negedge clk) begin
        q_neg <= d;
    end
    
    // Mux to select the value based on the clock edge
    always @(*) begin
        if (clk) begin
            q = q_pos;
        end else begin
            q = q_neg;
        end
    end
    
endmodule
