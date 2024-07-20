module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

// Define helper functions to get neighbors
function automatic [15:0] get_left(input [15:0] row);
    return {row[0], row[15:1]};
endfunction

function automatic [15:0] get_right(input [15:0] row);
    return {row[14:0], row[15]};
endfunction

function automatic [15:0] get_up(input [255:0] grid, input integer row_idx);
    return (row_idx == 0) ? grid[15:0] : grid[(row_idx-1)*16 +: 16];
endfunction

function automatic [15:0] get_down(input [255:0] grid, input integer row_idx);
    return (row_idx == 15) ? grid[255:240] : grid[(row_idx+1)*16 +: 16];
endfunction

// Main logic
always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        for (int row_idx = 0; row_idx < 16; row_idx++) begin
            for (int col_idx = 0; col_idx < 16; col_idx++) begin
                // Count neighbors
                int neighbors = 0;
                neighbors += q[row_idx*16 + col_idx]; // Self
                neighbors += get_left(q[row_idx*16 +: 16])[col_idx];
                neighbors += get_right(q[row_idx*16 +: 16])[col_idx];
                neighbors += get_up(q, row_idx)[col_idx];
                neighbors += get_down(q, row_idx)[col_idx];

                // Update state
                case (neighbors)
                    0, 1: q[row_idx*16 + col_idx] <= 1'b0;
                    2: q[row_idx*16 + col_idx] <= q[row_idx*16 + col_idx];
                    3: q[row_idx*16 + col_idx] <= 1'b1;
                    default: q[row_idx*16 + col_idx] <= 1'b0;
                endcase
            end
        end
    end
end

endmodule
