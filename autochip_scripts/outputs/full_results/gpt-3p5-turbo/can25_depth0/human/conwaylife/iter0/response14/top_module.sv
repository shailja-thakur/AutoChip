module top_module (
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);
    reg [255:0] q_next;
    integer i, j;
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    q_next[i*16 + j] = checkNeighbors(i,j);
                end
            end
            q <= q_next;
        end
    end
    
    function checkNeighbors;
    input [3:0] i, j;
    begin
        integer count;
        
        count = q[i*16 + (j-1)] + q[i*16 + (j+1)] + q[((i-1) mod 16)*16 + j] + q[((i+1) mod 16)*16 + j] + q[((i-1) mod 16)*16 + (j-1)] + q[((i-1) mod 16)*16 + (j+1)] + q[((i+1) mod 16)*16 + (j-1)] + q[((i+1) mod 16)*16 + (j+1)];
        
        if (count == 2) begin
            checkNeighbors = q[i*16 + j];
        end else if (count == 3) begin
            checkNeighbors = 1;
        end else begin
            checkNeighbors = 0;
        end
    end
    endfunction
    
endmodule
