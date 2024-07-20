module top_module( 
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q); 
    reg slowena_reg;
    
    always @(posedge clk) begin 
        if (reset) begin
            q <= 0;
            slowena_reg <= 0;
        end
        else begin
            slowena_reg <= slowena;
            if (slowena_reg)
                q <= q + 1;
            else
                q <= q;
        end
    end 
    
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, top_module);
        $finish;
    end
endmodule
