module rule110(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Create a temporary array to hold the updated state of the cells
    reg [511:0] q_temp;

    always @(posedge clk) begin
        if (load) begin
            // Load the data into q
            q <= data;
        end else begin
            // Calculate the next state of q based on the Rule 110 logic
            q_temp[0] <= (~q[1] & q[0]) ^ (q[1] | ~q[0]);
            q_temp[511] <= (q[511] & ~q[510]) ^ (q[511] | ~q[510]);

            for (integer i = 1; i < 511; i = i + 1) begin
                q_temp[i] <= (q[i-1] & q[i] & ~q[i+1]) ^ (q[i-1] & q[i] | q[i-1] & ~q[i+1] | q[i] & ~q[i+1]);
            end

            // Update q with the new state
            q <= q_temp;
        end
    end
endmodule
