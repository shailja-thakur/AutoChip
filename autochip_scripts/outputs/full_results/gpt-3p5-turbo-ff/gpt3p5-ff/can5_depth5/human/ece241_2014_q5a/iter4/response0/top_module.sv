module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] sum;
reg [8:0] temp; // Increase the size of temp by 1 bit

always @(posedge clk or posedge areset) begin
    if (areset)
        count <= 8'd0;
    else if (count < 8'd7)
        count <= count + 1'd1;
    else
        count <= 8'd0;
end

always @(posedge clk or posedge areset) begin
    if (areset)
        sum <= 8'd0;
    else if (count == 8'd0)
        temp <= {8'b0, ~x + 1}; // Concatenate 0 as MSB with ~x+1
    else
        temp <= {temp[7:0], temp[8]}; // Shift the bits of temp
end

always @(posedge clk or posedge areset) begin
    if (areset)
        z <= 8'd0;
    else
        z <= temp[7:0]; // Assign the last 8 bits of temp to output z
end

endmodule
