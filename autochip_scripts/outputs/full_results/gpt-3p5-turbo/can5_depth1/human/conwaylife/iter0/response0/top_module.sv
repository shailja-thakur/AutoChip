module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

reg [255:0] next_q;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        // Calculate the next state of each cell
        for (int i = 0; i < 256; i = i + 1) begin
            // Calculate the row and column indices of the current cell
            int row = i / 16;
            int col = i % 16;

            // Count the number of alive neighbors for the current cell
            int count = 0;
            if (q[((row + 15) % 16) * 16 + ((col + 1) % 16)]) begin
                count = count + 1;
            end
            if (q[((row + 15) % 16) * 16 + ((col + 16) % 16)]) begin
                count = count + 1;
            end
            if (q[((row + 15) % 16) * 16 + ((col + 15) % 16)]) begin
                count = count + 1;
            end
            if (q[((row + 1) % 16) * 16 + ((col + 1) % 16)]) begin
                count = count + 1;
            end
            if (q[((row + 1) % 16) * 16 + ((col + 15) % 16)]) begin
                count = count + 1;
            end
            if (q[((row - 1 + 16) % 16) * 16 + ((col + 1) % 16)]) begin
                count = count + 1;
            end
            if (q[((row - 1 + 16) % 16) * 16 + ((col + 16) % 16)]) begin
                count = count + 1;
            end
            if (q[((row - 1 + 16) % 16) * 16 + ((col + 15) % 16)]) begin
                count = count + 1;
            end

            // Determine the next state of the current cell based on the number of neighbors
            if (count == 3) begin
                next_q[i] = 1;
            end else if (count == 2) begin
                next_q[i] = q[i];
            end else begin
                next_q[i] = 0;
            end
        end

        // Update the current state with the next state
        q <= next_q;
    end
end

endmodule
