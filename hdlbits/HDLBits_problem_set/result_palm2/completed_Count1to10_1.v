module top_module (
    input clk,
    input reset,
    output [3:0] q);

    reg [3:0] counter = 1;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 1;
        end else begin
            counter <= counter + 1;
            if (counter == 10) begin
                counter <= 1;
            end
        end
    end

    assign q = counter;

endmodule