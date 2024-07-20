module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q <= next_state;
    end
end

always @* begin
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        if (i > 0)         neighbors += q[i-1];
        if (i < 255)       neighbors += q[i+1];
        if (i >= 16)       neighbors += q[i-16];
        if (i < 240)       neighbors += q[i+16];
        if (i > 0 && i >= 16)   neighbors += q[i-17];
        if (i > 0 && i < 240)   neighbors += q[i+15];
        if (i < 255 && i >= 16) neighbors += q[i-15];
        if (i < 255 && i < 240) neighbors += q[i+17];
        
        if (q[i] == 1'b1) begin
            if (neighbors < 2 || neighbors > 3) begin
                next_state[i] = 1'b0;
            end
            else begin
                next_state[i] = 1'b1;
            end
        end
        else begin
            if (neighbors == 3) begin
                next_state[i] = 1'b1;
            end
            else begin
                next_state[i] = 1'b0;
            end
        end
    end
end

endmodule
