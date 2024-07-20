module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] temp_q; // temporary variable to store the updated state

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Process each cell and update its state based on the Rule 90
            // For boundary cells, consider the boundary value as 0 (off)

            for (integer i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    temp_q[i] = q[i+1] ^ q[i];
                end else if (i == 511) begin
                    temp_q[i] = q[i-1] ^ q[i];
                end else begin
                    temp_q[i] = q[i-1] ^ q[i+1] ^ q[i];
                end
            end

            q <= temp_q;
        end
    end

endmodule
