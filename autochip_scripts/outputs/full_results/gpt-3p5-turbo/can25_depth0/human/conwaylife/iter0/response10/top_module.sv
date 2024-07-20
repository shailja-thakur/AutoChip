module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    wire [255:0] q_next;
    
    // Internal wires for cell neighbors
    wire [255:0] q_neighbor;
    wire [255:0] q_neighbor_shifted;
    wire [255:0] q_neighbor_wrapped;
    
    // Count of number of neighbors for each cell
    wire [255:0] neighbor_count;
    
    // Update the game state based on the rules
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= q_next;
        end
    end
    
    // Generate the next state of the game
    always @(*) begin
        q_next = q;
        
        // Calculate the neighbors for each cell
        gen_neighbors();
        
        // Count the number of alive neighbors for each cell
        gen_neighbor_count();
        
        // Apply the rules of the game to each cell
        apply_rules();
    end
    
    // Generate the neighbors for each cell
    // Wrap around at the edges of the grid
    // We use shifts to generate the neighbors
    // and wrap around at the edges
    function gen_neighbors;
        begin
            for (integer i = 0; i < 16; i = i + 1) begin
                q_neighbor[i*16 +: 16] = q[i*16 +: 16] << 1; // Left neighbor
                q_neighbor[i*16 +: 16] = q[i*16 +: 16] >> 1; // Right neighbor
                q_neighbor_shifted[i*16 +: 16] = q[i*16 +: 16] << 16; // Down neighbor
                q_neighbor_shifted[i*16 +: 16] = q[i*16 +: 16] >> 16; // Up neighbor
            end
            
            q_neighbor_wrapped = {q[239:0], q[255:240]}; // Wrap around at the edges of the grid
        end
    endfunction
    
    // Count the number of alive neighbors for each cell
    function gen_neighbor_count;
        begin
            for (integer i = 0; i < 256; i = i + 1) begin
                neighbor_count[i] = q_neighbor[i] + q_neighbor[i+16] + q_neighbor[i-16]
                                    + q_neighbor_wrapped[i-1] + q_neighbor_wrapped[i+1]
                                    + q_neighbor_wrapped[i+15] + q_neighbor_wrapped[i-15]
                                    + q_neighbor_wrapped[i+17] + q_neighbor_wrapped[i-17];
            end
        end
    endfunction
    
    // Apply the rules of the game to each cell
    function apply_rules;
        begin
            for (integer i = 0; i < 256; i = i + 1) begin
                case (neighbor_count[i])
                    2: q_next[i] = q[i]; // Cell state does not change
                    3: q_next[i] = 1; // Cell becomes 1
                    default: q_next[i] = 0; // Cell becomes 0
                endcase
            end
        end
    endfunction
    
endmodule
