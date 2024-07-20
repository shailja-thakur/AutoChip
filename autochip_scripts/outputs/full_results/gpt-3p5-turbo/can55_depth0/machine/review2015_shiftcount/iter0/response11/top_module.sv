module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);
    
    always @ (posedge clk) begin  // Triggered by the clk signal
        
        if (shift_ena) begin  // Shift operation enabled
            q <= data;
        end
        
        else if (count_ena) begin  // Decrement operation enabled
            q <= q - 1;
        end
        
    end
    
endmodule
