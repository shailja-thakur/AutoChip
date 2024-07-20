module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
);

    reg [99:0] temp;
    reg [1:0] reg_ena;

    always @(posedge clk) begin
        if (load)
            temp <= data;
        else begin
            case (ena)
                2'b01: temp <= {temp[98:0], 1'b0};
                2'b10: temp <= {1'b0, temp[99:1]};
            endcase
        end
    end
    
    always @*
        q <= temp;

endmodule
