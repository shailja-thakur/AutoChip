module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Intermediate register to hold the next state of the cells
    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            // If load is high, set q to data
            q <= data;
        end else begin
            // Otherwise, calculate the next state according to Rule 110
            next_q[0] = q[1]; // Boundary condition: q[-1] is assumed to be 0
            next_q[511] = q[510]; // Boundary condition: q[512] is assumed to be 0
            
            // Iterate through the cells and apply Rule 110
            for (int i = 1; i < 511; i = i + 1) begin
                // Coding Rule 110
                case ({q[i+1], q[i], q[i-1]})
                    3'b111: next_q[i] = 0;
                    3'b110: next_q[i] = 1;
                    3'b101: next_q[i] = 1;
                    3'b100: next_q[i] = 0;
                    3'b011: next_q[i] = 1;
                    3'b010: next_q[i] = 1;
                    3'b001: next_q[i] = 1;
                    3'b000: next_q[i] = 0;
                endcase
            end
            
            // Update the cell states for the next clock cycle
            q <= next_q;
        end
    end
endmodule
