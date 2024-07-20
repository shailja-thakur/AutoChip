module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    always @(posedge clk) begin
        if(load) begin
            q <= data;
        end else begin
            for(int i=0; i<512; i=i+1) begin
                if(i == 0) begin
                    if(q[i] && q[i+1] && q[511])
                        q[i] <= 0;
                    else if(q[i] && q[i+1] && !q[511])
                        q[i] <= 1;
                    else if(q[i] && !q[i+1] && q[511])
                        q[i] <= 1;
                    else if(q[i] && !q[i+1] && !q[511])
                        q[i] <= 0;
                    else if(!q[i] && q[i+1] && q[511])
                        q[i] <= 1;
                    else if(!q[i] && q[i+1] && !q[511])
                        q[i] <= 1;
                    else if(!q[i] && !q[i+1] && q[511])
                        q[i] <= 1;
                    else if(!q[i] && !q[i+1] && !q[511])
                        q[i] <= 0;
                end else if(i == 511) begin
                    if(q[i-1] && q[i] && q[0])
                        q[i] <= 0;
                    else if(q[i-1] && q[i] && !q[0])
                        q[i] <= 1;
                    else if(q[i-1] && !q[i] && q[0])
                        q[i] <= 1;
                    else if(q[i-1] && !q[i] && !q[0])
                        q[i] <= 0;
                    else if(!q[i-1] && q[i] && q[0])
                        q[i] <= 1;
                    else if(!q[i-1] && q[i] && !q[0])
                        q[i] <= 1;
                    else if(!q[i-1] && !q[i] && q[0])
                        q[i] <= 1;
                    else if(!q[i-1] && !q[i] && !q[0])
                        q[i] <= 0;
                end else begin
                    if(q[i-1] && q[i] && q[i+1])
                        q[i] <= 0;
                    else if(q[i-1] && q[i] && !q[i+1])
                        q[i] <= 1;
                    else if(q[i-1] && !q[i] && q[i+1])
                        q[i] <= 1;
                    else if(q[i-1] && !q[i] && !q[i+1])
                        q[i] <= 0;
                    else if(!q[i-1] && q[i] && q[i+1])
                        q[i] <= 1;
                    else if(!q[i-1] && q[i] && !q[i+1])
                        q[i] <= 1;
                    else if(!q[i-1] && !q[i] && q[i+1])
                        q[i] <= 1;
                    else if(!q[i-1] && !q[i] && !q[i+1])
                        q[i] <= 0;
                end
            end
        end
    end
endmodule
