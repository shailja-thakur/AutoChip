module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 

    logic [255:0] next_state;

    // Compute the next state of the game.
    always @(posedge clk) begin
        if (load) begin
            next_state <= data;
        end else begin
            for (int i = 0; i < 256; i++) begin
                int n_neighbours = 0;
                for (int j = 0; j < 16; j++) begin
                    int x = i + j;
                    if (x < 0) begin
                        x = 256 + x;
                    elsif (x >= 256) begin
                        x = x - 256;
                    endif
                    n_neighbours = n_neighbours + (next_state[x] == 1);
                end
                next_state[i] = (next_state[i] == 1) ? (n_neighbours == 2 || n_neighbours == 3) : (n_neighbours == 3);
            end
        end
        q <= next_state;
    end

endmodule