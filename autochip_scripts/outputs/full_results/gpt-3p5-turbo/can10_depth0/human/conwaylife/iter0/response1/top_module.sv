module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;
    
    always@(posedge clk)
    begin
        if(load)
        begin
            q <= data;
        end
        else
        begin
            for (int i=0; i<16; i=i+1)
            begin
                for (int j=0; j<16; j=j+1)
                begin
                    int sum = 0;
                    sum = q[(i-1)*16 + (j-1)] + q[(i-1)*16 + j] + q[(i-1)*16 + (j+1)] + 
                          q[i*16 + (j-1)] + q[i*16 + (j+1)] +
                          q[((i+1)%16)*16 + (j-1)] + q[((i+1)%16)*16 + j] + q[((i+1)%16)*16 + (j+1)];
                    if (sum<=1)
                        next_q[i*16 + j] = 0;
                    else if (sum==2)
                        next_q[i*16 + j] = q[i*16 + j];
                    else if (sum==3)
                        next_q[i*16 + j] = 1;
                    else if (sum>=4)
                        next_q[i*16 + j] = 0;
                end
            end
            q <= next_q;
        end
    end
    
endmodule
