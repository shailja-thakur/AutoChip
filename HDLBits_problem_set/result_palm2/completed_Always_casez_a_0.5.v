module top_module (
    input [7:0] in,
    output reg [2:0] pos );

    // Insert your code here

    always @(in or pos) begin
        if (in[7]) begin
            pos <= 3'd7;
        end else if (in[6]) begin
            pos <= 3'd6;
        end else if (in[5]) begin
            pos <= 3'd5;
        end else if (in[4]) begin
            pos <= 3'd4;
        end else if (in[3]) begin
            pos <= 3'd3;
        end else if (in[2]) begin
            pos <= 3'd2;
        end else if (in[1]) begin
            pos <= 3'd1;
        end else if (in[0]) begin
            pos <= 3'd0;
        end
    end

endmodule