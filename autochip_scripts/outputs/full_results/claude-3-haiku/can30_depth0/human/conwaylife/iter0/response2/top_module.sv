module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    // Internal variables
    reg [255:0] next_state;
    reg [3:0] x, y;
    reg [3:0] north, south, east, west;

    // Update game state on each clock cycle
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_state;
        end
    end

    // Calculate next state
    always @(*) begin
        next_state = q;
        for (x = 0; x < 16; x = x + 1) begin
            for (y = 0; y < 16; y = y + 1) begin
                // Calculate neighboring cells
                north = (y == 0) ? q[((x+1)%16)+255-16] : q[((x+1)%16)+((y-1)*16)];
                south = (y == 15) ? q[((x+1)%16)] : q[((x+1)%16)+((y+1)*16)];
                east = q[((x+1)%16)+((y)*16)];
                west = (x == 0) ? q[((x+15)%16)+((y)*16)] : q[((x-1)%16)+((y)*16)];

                // Apply game rules
                if (q[((x)%16)+((y)*16)] == 1'b1) begin // Cell is alive
                    if (north + south + east + west < 2 || north + south + east + west > 3) begin
                        next_state[((x)%16)+((y)*16)] = 1'b0; // Cell dies
                    end
                end else begin // Cell is dead
                    if (north + south + east + west == 3) begin
                        next_state[((x)%16)+((y)*16)] = 1'b1; // Cell becomes alive
                    end
                end
            end
        end
    end

endmodule
