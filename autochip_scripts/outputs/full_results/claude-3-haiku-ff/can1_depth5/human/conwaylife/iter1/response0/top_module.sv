module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    reg [255:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            q <= next_q;
        end
    end

    always @(*) begin
        for (int i = 0; i < 256; i++) begin
            int neighbors = 0;
            if (i > 0 && q[i-1]) neighbors++; // Left
            if (i < 255 && q[i+1]) neighbors++; // Right
            if (i >= 16 && q[i-16]) neighbors++; // Up
            if (i < 240 && q[i+16]) neighbors++; // Down
            if (i > 15 && q[i-17]) neighbors++; // Up-Left
            if (i < 239 && q[i+17]) neighbors++; // Down-Right
            if (i >= 16 && i < 240 && q[i-15]) neighbors++; // Up-Right
            if (i >= 15 && i < 241 && q[i+15]) neighbors++; // Down-Left

            case (neighbors)
                0, 1: next_q[i] = 0;
                2: next_q[i] = q[i];
                3: next_q[i] = 1;
                default: next_q[i] = 0;
            endcase
        end
    end

endmodule
