module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
);

    reg [99:0] temp;
    reg [1:0] reg_ena;
    wire [99:0] shifted_data;

    always @(posedge clk) begin
        if (load) begin
            temp <= data;
            q <= data;
        end else begin
            reg_ena <= ena;
            case (reg_ena)
                2'b01: begin
                    shifted_data = {temp[98:0], 1'b0};
                end
                2'b10: begin
                    shifted_data = {1'b0, temp[99:1]};
                end
            endcase
            q <= shifted_data;
            temp <= shifted_data;
        end
    end
endmodule
