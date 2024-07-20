module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
    
    // Function to calculate the toroidal index for neighbors
    function [3:0] toroidal_index;
        input [3:0] value, max_value;
        input [1:0] offset;
    begin
        case (offset)
            2'b00: toroidal_index = (value == 0) ? max_value : value - 1;
            2'b01: toroidal_index = value;
            2'b10: toroidal_index = (value == max_value) ? 0 : value + 1;
            default: toroidal_index = value; // Should never be here
        endcase
    end
    endfunction
    
    reg [255:0] next_q;
    
    always @(*) begin
        integer i, j, k, l;
        reg [4:0] neighbor_count;
        
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                neighbor_count = 0;
                // Calculate neighbors
                for (k = 0; k < 3; k = k + 1) begin
                    for (l = 0; l < 3; l = l + 1) begin
                        if (!(k == 1 && l == 1)) begin
                            neighbor_count = neighbor_count + q[toroidal_index(i, 15, k) * 16 + toroidal_index(j, 15, l)];
                        end
                    end
                end
                
                // Determine next state based on neighbor count
                if (neighbor_count < 2 || neighbor_count > 3) begin
                    next_q[i * 16 + j] = 0;
                end else if (neighbor_count == 3) begin
                    next_q[i * 16 + j] = 1;
                end else begin
                    next_q[i * 16 + j] = q[i * 16 + j];
                end
            end
        end
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end
endmodule
