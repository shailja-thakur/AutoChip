module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    wire [255:0] q_next;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= q_next;
        end
    end

    generate
        genvar i, j;
        for (i = 0; i < 16; i = i+1) begin: ROW
            for (j = 0; j < 16; j = j+1) begin: COLUMN
                assign q_next[i*16 + j] = next_state(q, i, j);
            end
        end
    endgenerate

    function next_state(input [255:0] q, input integer i, input integer j);
        reg count;
        begin
            count = q[i*16 + ((j+1)%16)] + q[((i-1+16)%16)*16 + ((j+1)%16)] + q[((i-1+16)%16)*16 + j] + q[((i-1+16)%16)*16 + ((j-1+16)%16)] + q[i*16 + ((j-1+16)%16)] + q[((i+1)%16)*16 + ((j-1+16)%16)] + q[((i+1)%16)*16 + j] + q[((i+1)%16)*16 + ((j+1)%16)];
            case (count)
                0, 1: next_state = 0;
                2: next_state = q[i*16 + j];
                3: next_state = 1;
                default: next_state = 0;
            endcase
        end
    endfunction

endmodule
