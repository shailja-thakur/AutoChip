module top_module (
    input [2:0] in,
    output [1:0] out );

    reg [2:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
        end else begin
            if (in[2] == 1) begin
                count <= count + 1;
            end
            if (in[1] == 1) begin
                count <= count + 1;
            end
            if (in[0] == 1) begin
                count <= count + 1;
            end
        end
    end

    assign out = count[1:0];

endmodule