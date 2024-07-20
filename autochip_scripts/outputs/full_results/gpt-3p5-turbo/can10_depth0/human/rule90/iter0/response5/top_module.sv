module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] temp;
    integer i;

    always @(posedge clk) begin
        if (load) begin
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0 || i == 511)
                    temp[i] = 0;
                else begin
                    case ({q[i-1], q[i], q[i+1]}) // Check current neighbors
                        3'b000: temp[i] = 0; // Left | Center | Right
                        3'b001: temp[i] = 1;
                        3'b010: temp[i] = 0;
                        3'b011: temp[i] = 1;
                        3'b100: temp[i] = 1;
                        3'b101: temp[i] = 0;
                        3'b110: temp[i] = 1;
                        3'b111: temp[i] = 0;
                    endcase
                end
            end
            q <= temp;
        end
    end

endmodule
