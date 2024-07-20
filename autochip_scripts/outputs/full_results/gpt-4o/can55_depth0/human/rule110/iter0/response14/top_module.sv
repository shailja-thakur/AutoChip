module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Intermediate wire to hold the next state of the cells
    reg [511:0] next_q;

    // Process the next state based on Rule 110
    integer i;
    always @* begin
        for (i = 0; i < 512; i = i + 1) begin
            case ({(i > 0 ? q[i-1] : 0), q[i], (i < 511 ? q[i+1] : 0)})
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
    end

    // Update the state of the system
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end
endmodule
