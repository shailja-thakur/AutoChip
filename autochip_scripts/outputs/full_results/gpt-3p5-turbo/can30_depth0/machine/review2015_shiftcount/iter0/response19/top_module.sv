module top_module(
    input wire clk,
    input wire shift_ena,
    input wire count_ena,
    input wire data,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (shift_ena) begin
            q <= data; // Shift data into q if shift_ena is high
        end else begin
            if (count_ena) begin
                q <= q - 1; // Decrement q if count_ena is high
            end
        end
    end
endmodule
