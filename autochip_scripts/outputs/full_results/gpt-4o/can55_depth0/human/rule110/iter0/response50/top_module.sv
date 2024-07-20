module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;

    always @(*) begin
        next_q[0] = (q[1] == 1'b1) ? 1'b1 : 1'b0; // q[-1] is considered 0

        next_q[511] = (q[510] == 1'b1) ? 1'b1 : 1'b0; // q[512] is considered 0

        integer i;
        for (i = 1; i <= 510; i = i + 1) begin
            case ({q[i+1], q[i], q[i-1]})
                3'b111: next_q[i] = 1'b0;
                3'b110, 3'b101, 3'b011: next_q[i] = 1'b1;
                3'b100, 3'b001, 3'b000: next_q[i] = 1'b0;
                default: next_q[i] = 1'b0;
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end
endmodule
