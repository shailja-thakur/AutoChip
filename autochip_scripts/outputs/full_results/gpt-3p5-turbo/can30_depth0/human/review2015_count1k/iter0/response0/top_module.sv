module top_module(
    input clk,
    input reset,
    output reg [9:0] q
);

// Reg for storing the counter value
reg [9:0] count;

// Sequential logic for counting
always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 0;
    end else begin
        if (count == 999) begin
            count <= 0;
        end else begin
            count <= count + 1;
        end
    end
end

// Assign the value of the count to the output
assign q = count;

endmodule
