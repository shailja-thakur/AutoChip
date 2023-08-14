module top_module (
    input [3:0] in,
    output reg [1:0] pos  );

    // Insert your code here

    always @(pos or in) begin
        if (pos[1]) begin
            pos <= 4'b0011;
        end else if (pos[0]) begin
            pos <= 4'b0100;
        end else if (in[3]) begin
            pos <= 4'b1000;
        end else if (in[2]) begin
            pos <= 4'b1001;
        end else if (in[1]) begin
            pos <= 4'b1010;
        end else if (in[0]) begin
            pos <= 4'b1011;
        end
    end

endmodule