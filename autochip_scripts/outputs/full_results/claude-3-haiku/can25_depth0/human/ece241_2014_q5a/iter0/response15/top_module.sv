module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] temp;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        count <= 8'b0;
        temp <= 8'b0;
        z <= 1'b0;
    end
    else begin
        if (count == 8'd0) begin
            temp <= 8'b0;
        end
        else begin
            temp[count-1] <= x;
            count <= count - 1;
        end
        
        if (count == 8'd1) begin
            z <= ~temp + 1;
        end
        else begin
            count <= count + 1;
        end
    end
end

endmodule
