module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    reg [3:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0001;  // Reset the count to 1
        end else begin
            if (count == 4'b1010) begin
                count <= 4'b0001;  // Reset the count to 1
            end else begin
                count <= count + 1;  // Increment the count
            end
        end
    end

    assign q = count;

endmodule
