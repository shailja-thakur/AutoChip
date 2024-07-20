module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

    reg [7:0] q;

    always @(posedge clk) begin
        if (enable) begin
            q = {q[6:0], S};
        end
    end

    always @(*) begin
        case ({A, B, C})
            3'd0: Z = q[0];
            3'd1: Z = q[1];
            3'd2: Z = q[2];
            3'd3: Z = q[3];
            3'd4: Z = q[4];
            3'd5: Z = q[5];
            3'd6: Z = q[6];
            3'd7: Z = q[7];
            default: Z = 1'b0; // Default case to handle any invalid input
        endcase
    end

endmodule
