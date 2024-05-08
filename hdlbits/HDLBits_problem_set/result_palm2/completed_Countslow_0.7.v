module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);

    reg [3:0] counter;
    reg enable;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
            enable <= 1;
        end else begin
            if (slowena) begin
                counter <= counter + 1;
            end
        end
    end

    assign q = counter;

endmodule