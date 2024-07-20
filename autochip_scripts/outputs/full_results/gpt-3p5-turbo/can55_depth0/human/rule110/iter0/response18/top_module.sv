module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (int i = 0; i < 512; i = i + 1) begin
                q[i] <= next_state(q[i-1], q[i], q[i+1]);
            end
        end
    end

    function next_state;
        input left, center, right;
        reg next;

        always @(*) begin
            case ({left, center, right})
                3'b111: next = 1'b0;
                3'b110: next = 1'b1;
                3'b101: next = 1'b1;
                3'b100: next = 1'b0;
                3'b011: next = 1'b1;
                3'b010: next = 1'b1;
                3'b001: next = 1'b1;
                3'b000: next = 1'b0;
            endcase
        end

        next_state = next;
    endfunction

endmodule
