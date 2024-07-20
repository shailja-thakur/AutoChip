module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            integer i;
            reg [511:0] next_q;
            for (i = 0; i < 512; i = i + 1) begin
                // Boundary conditions
                if (i == 0) begin
                    next_q[i] <= (q[i + 1] == 1'b1) ? 1'b1 : 1'b0;
                end else if (i == 511) begin
                    next_q[i] <= (q[i - 1] == 1'b1) ? 1'b1 : 1'b0;
                end else begin
                    // Rule 110 logic
                    case ({q[i-1], q[i], q[i+1]})
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
