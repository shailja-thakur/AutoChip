module top_module(
    input clk,
    input d,
    output reg q);
    
    reg q_posedge, q_negedge;
    
    always @(posedge clk) begin
        q_posedge <= d;
    end
    
    always @(negedge clk) begin
        q_negedge <= d;
    end
    
    always @* begin
        if (clk) begin
            q = q_posedge;
        end else begin
            q = q_negedge;
        end
    end

endmodule
