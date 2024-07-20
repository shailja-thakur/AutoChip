module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    // On clock, propagate the states
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            integer i;

            reg [511:0] new_q;
            
            // Compute the next state for each cell
            for (i = 0; i < 512; i = i + 1) begin
                // Boundary conditions (q[-1] and q[512] are zero)
                if (i == 0)
                    new_q[i] = ({1'b0, q[0], q[1]} == 3'b110) || ({1'b0, q[0], q[1]} == 3'b101) || ({1'b0, q[0], q[1]} == 3'b011);
                else if (i == 511)
                    new_q[i] = ({q[510], q[511], 1'b0} == 3'b110) || ({q[510], q[511], 1'b0} == 3'b101) || ({q[510], q[511], 1'b0} == 3'b011);
                else
                    new_q[i] = ({q[i-1], q[i], q[i+1]} == 3'b110) || ({q[i-1], q[i], q[i+1]} == 3'b101) || ({q[i-1], q[i], q[i+1]} == 3'b011);
            end

            // Update the state
            q <= new_q;
        end
    end
endmodule
