module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] next_q;
            integer i;
            
            // Update each cell according to the Rule 110 transition table
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    // Boundary condition for the leftmost cell
                    next_q[i] <= (q[1] == 1'b1 && q[0] == 1'b1) ? 1'b1 : (q[1] == 1'b1 && q[0] == 1'b0) ? 1'b1 : (q[1] == 0 && q[0] == 1) ? 1'b1 : 1'b0;
                end else if (i == 511) begin
                    // Boundary condition for the rightmost cell
                    next_q[i] <= (q[510] == 1'b1 && q[511] == 1'b0) ? 1'b1 : (q[510] == 1'b0 && q[511] == 1'b0) ? 1'b0 : (q[510] == 1'b1 && q[511] == 1'b1) ? 1'b0 : 1'b0;
                end else begin
                    // General case for all other cells
                    case({q[i+1], q[i], q[i-1]})
                        3'b111: next_q[i] <= 1'b0;
                        3'b110: next_q[i] <= 1'b1;
                        3'b101: next_q[i] <= 1'b1;
                        3'b100: next_q[i] <= 1'b0;
                        3'b011: next_q[i] <= 1'b1;
                        3'b010: next_q[i] <= 1'b1;
                        3'b001: next_q[i] <= 1'b1;
                        3'b000: next_q[i] <= 1'b0;
                    endcase
                end
            end
            
            q <= next_q;
        end
    end
endmodule
