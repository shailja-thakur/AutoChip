module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load state
        end else begin
            // Create a temporary array to hold the next state of q
            reg [511:0] next_q;
            
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                // Determine the left, center, and right neighbors
                reg left, center, right;
                if (i == 0) 
                    left = 0; // Boundaries are off
                else 
                    left = q[i-1];

                center = q[i];

                if (i == 511)
                    right = 0; // Boundaries are off
                else
                    right = q[i+1];

                // Compute next state based on Rule 110
                case ({left, center, right})
                    3'b111: next_q[i] = 0;
                    3'b110: next_q[i] = 1;
                    3'b101: next_q[i] = 1;
                    3'b100: next_q[i] = 0;
                    3'b011: next_q[i] = 1;
                    3'b010: next_q[i] = 1;
                    3'b001: next_q[i] = 1;
                    3'b000: next_q[i] = 0;
                    default: next_q[i] = 0; // Should never happen
                endcase
            end

            // Update the state
            q <= next_q;
        end
    end

endmodule
