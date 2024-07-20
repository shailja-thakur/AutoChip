module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    reg [2:0] state;

    always @(posedge clk) begin
        case (y)
            3'b000: begin
                if (x == 1'b0) state <= 3'b000;
                else state <= 3'b001;
            end
            3'b001: begin
                if (x == 1'b0) state <= 3'b001;
                else state <= 3'b100;
            end
            3'b010: begin
                if (x == 1'b0) state <= 3'b010;
                else state <= 3'b001;
            end
            3'b011: begin
                if (x == 1'b0) state <= 3'b001;
                else state <= 3'b010;
            end
            3'b100: begin
                if (x == 1'b0) state <= 3'b011;
                else state <= 3'b100;
            end
            default: state <= 3'b000;
        endcase
    end

    always @(posedge clk) begin
        case (y)
            3'b011, 3'b100: z <= 1;
            default: z <= 0;
        endcase
    end
    
    always @(posedge clk) begin
        Y0 <= state[0];
    end

endmodule
