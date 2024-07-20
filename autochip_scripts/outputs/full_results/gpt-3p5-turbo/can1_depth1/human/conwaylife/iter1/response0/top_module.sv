module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
        
    reg [255:0] next_q;
    wire [15:0] row_stb;
    wire [15:0] row_sig;
    wire [255:0] wrap_row;
    
    // Generate row strobes
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin: ROW_GEN
            assign row_stb[i] = (i == 0) ? 1'b1 : (next_q[i * 16] == 1'b1 && next_q[(i * 16) - 1] == 1'b0);
        end
    endgenerate
    
    // Generate row signals
    genvar j;
    generate
        for (j = 0; j < 16; j = j + 1) begin: ROW_SIGNAL_GEN
            assign row_sig[j] = (j == 0) ? row_stb[15] : row_stb[j - 1];
        end
    endgenerate
    
    // Generate wrap around rows
    genvar k;
    generate
        for (k = 0; k < 256; k = k + 16) begin: WRAP_ROW_GEN
            assign wrap_row[k +: 16] = {q[k +: 16], q[k]};
        end
    endgenerate
    
    // Generate next state
    always @(posedge clk) begin
        if (load) begin
            next_q <= data;
        end 
        else begin
            next_q <= q;
            for (k = 0; k < 256; k = k + 16) begin
                if (row_sig[k / 16]) begin
                    // Calculate number of neighbors
                    reg [3:0] n;
                    n = wrap_row[k +: 16] + wrap_row[k + 16 +: 16] + wrap_row[k + 32 +: 16] + wrap_row[k - 16 +: 16] + wrap_row[k - 32 +: 16] + wrap_row[k + 15] + wrap_row[k + 1] + wrap_row[k - 1];
                    
                    // Update cell state based on number of neighbors
                    for (j = 0; j < 16; j = j + 1) begin
                        if (n[j] >= 4) begin
                            next_q[k + j] <= 1'b0;
                        end 
                        else if (n[j] == 3) begin
                            next_q[k + j] <= 1'b1;
                        end 
                        else if (n[j] == 2) begin
                            next_q[k + j] <= q[k + j];
                        end 
                        else begin
                            next_q[k + j] <= 1'b0;
                        end
                    end
                end 
                else begin
                  next_q[k +: 16] <= q[k +: 16];
                end
            end
        end
    end
    
    // Assign current state with next state
    always @(posedge clk) begin
        q <= next_q;
    end
    
endmodule
